#include "datamanager.h"
#include <QUrl>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>
#include <QRegularExpression>

DataManager::DataManager(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);
    m_mediaPlayer = new QMediaPlayer(this);
    m_audioOutput = new QAudioOutput(this);
    m_mediaPlayer->setAudioOutput(m_audioOutput);
    connect(m_mediaPlayer, &QMediaPlayer::positionChanged, this, &DataManager::updateLyricPosition);
}

void DataManager::initializeUserCollections(const QString &localId, const QString &idToken) {
    QJsonObject fields;
    fields["status"] = QJsonObject{{"stringValue", "initialized"}};
    QJsonObject payload;
    payload["fields"] = fields;
    QByteArray body = QJsonDocument(payload).toJson(QJsonDocument::Compact);

    auto initCollection = [this, idToken, body](const QString &path) {
        QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/%2/_meta")
                     .arg(projectId, path));
        QNetworkRequest req(url);
        req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        req.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());
        QNetworkReply *reply = networkManager->sendCustomRequest(req, "PATCH", body);
        connect(reply, &QNetworkReply::finished, [reply]() {
            qDebug() << "Inisialisasi koleksi selesai (PATCH _meta)";
            reply->deleteLater();
        });
    };

    initCollection(QString("users/%1/favorites").arg(localId));
    initCollection(QString("users/%1/followed").arg(localId));
}

void DataManager::createUserPlaylist(const QString &localId, const QString &idToken, const QString &playlistName) {
    if (localId.isEmpty() || idToken.isEmpty() || playlistName.isEmpty()) {
        qDebug() << "Gagal membuat playlist: Parameter kosong.";
        return;
    }

    QString playlistAman = QUrl::toPercentEncoding(playlistName);
    QString alamatUrl(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists?documentId=%3")
                          .arg(projectId, localId, playlistAman));

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fields;
    fields["playlist_name"] = QJsonObject{{"stringValue", playlistName}};

    // FIX: Simpan array benar-benar kosong, tanpa placeholder apapun
    fields["song_ids"] = QJsonObject{{"arrayValue", QJsonObject{}}};

    QJsonObject jsonPayload;
    jsonPayload["fields"] = fields;
    QByteArray payloadData = QJsonDocument(jsonPayload).toJson(QJsonDocument::Compact);

    QNetworkReply *reply = networkManager->post(request, payloadData);
    connect(reply, &QNetworkReply::finished, [reply, playlistName]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Playlist sukses terbuat di Firestore:" << playlistName;
        } else {
            qDebug() << "Gagal membuat playlist!" << reply->errorString() << reply->readAll();
        }
        reply->deleteLater();
    });
}

void DataManager::fetchUserPlaylists(const QString &localId, const QString &idToken) {
    // FIX: Sinyal ini memberitahu HalamanPlaylist untuk clear modelnya SEBELUM
    // item-item baru datang — mencegah keganda saat popup HalamanPemutaran juga memanggil fungsi ini.
    emit playlistFetchStarted();

    QString alamatUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists")
                            .arg(projectId, localId);

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject jsonObj = jsonDoc.object();
            QJsonArray documents = jsonObj["documents"].toArray();

            for (const QJsonValue &docVal : documents) {
                QJsonObject docObj = docVal.toObject();
                QJsonObject fields = docObj["fields"].toObject();

                QString playlistName = fields["playlist_name"].toObject()["stringValue"].toString();

                QJsonArray valuesArray = fields["song_ids"].toObject()["arrayValue"].toObject()["values"].toArray();

                int totalLagu = 0;
                for (const QJsonValue &v : valuesArray) {
                    QString id = v.toObject()["stringValue"].toString();
                    if (!id.isEmpty() && id != "EMPTY_PLAYLIST") totalLagu++;
                }

                QString songCountInfo = QString("%1 lagu").arg(totalLagu);
                emit playlistFetched(playlistName, songCountInfo);
            }
        } else {
            qDebug() << "Gagal mengambil data playlist:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::deleteUserPlaylist(const QString &localId, const QString &idToken, const QString &playlistName) {
    QString playlistAman = QUrl::toPercentEncoding(playlistName);
    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists/%3")
                 .arg(projectId, localId, playlistAman));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->sendCustomRequest(request, "DELETE");
    connect(reply, &QNetworkReply::finished, [this, reply, playlistName]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Playlist berhasil dihapus dari Firestore:" << playlistName;
            emit playlistDeleted(playlistName);
        } else {
            qDebug() << "Gagal menghapus playlist:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::addSongToPlaylist(const QString &localId, const QString &idToken,
                                    const QString &playlistName, const QString &songId) {
    if (localId.isEmpty() || idToken.isEmpty() || playlistName.isEmpty() || songId.isEmpty()) {
        qDebug() << "Gagal menambah lagu: Parameter kosong.";
        return;
    }

    QString playlistAman = QUrl::toPercentEncoding(playlistName);
    QString docUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists/%3")
                         .arg(projectId, localId, playlistAman);

    // FIX Step 1: GET playlist yang ada terlebih dahulu untuk membaca song_ids saat ini
    QNetworkRequest getRequest((QUrl(docUrl)));
    getRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *getReply = networkManager->get(getRequest);
    connect(getReply, &QNetworkReply::finished,
            [this, getReply, docUrl, idToken, playlistName, songId]() {

                // FIX Step 2: Baca array lama dari respons
                QJsonArray existingArray;
                if (getReply->error() == QNetworkReply::NoError) {
                    QJsonObject fields = QJsonDocument::fromJson(getReply->readAll())
                    .object()["fields"].toObject();
                    QJsonArray rawValues = fields["song_ids"].toObject()["arrayValue"]
                                               .toObject()["values"].toArray();

                    // Masukkan song_id lama ke array, abaikan placeholder
                    for (const QJsonValue &v : rawValues) {
                        QString id = v.toObject()["stringValue"].toString();
                        if (!id.isEmpty() && id != "EMPTY_PLAYLIST") {
                            existingArray.append(QJsonObject{{"stringValue", id}});
                        }
                    }
                } else {
                    qDebug() << "Peringatan GET playlist sebelum tambah lagu:" << getReply->errorString();
                }

                // FIX Step 3: Cek duplikat — jangan tambahkan lagu yang sudah ada
                for (const QJsonValue &v : existingArray) {
                    if (v.toObject()["stringValue"].toString() == songId) {
                        qDebug() << "Lagu" << songId << "sudah ada di playlist" << playlistName;
                        getReply->deleteLater();
                        return;
                    }
                }

                // FIX Step 4: Tambahkan lagu baru ke ujung array
                existingArray.append(QJsonObject{{"stringValue", songId}});

                // FIX Step 5: PATCH dengan array lengkap (lagu lama + lagu baru)
                QString patchUrl = docUrl + "?updateMask.fieldPaths=song_ids";
                QNetworkRequest patchRequest((QUrl(patchUrl)));
                patchRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
                patchRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

                QJsonObject fields;
                fields["song_ids"] = QJsonObject{{"arrayValue", QJsonObject{{"values", existingArray}}}};

                QJsonObject jsonPayload;
                jsonPayload["fields"] = fields;

                QNetworkReply *patchReply = networkManager->sendCustomRequest(
                    patchRequest, "PATCH", QJsonDocument(jsonPayload).toJson(QJsonDocument::Compact));

                connect(patchReply, &QNetworkReply::finished, [patchReply, playlistName, songId]() {
                    if (patchReply->error() == QNetworkReply::NoError) {
                        qDebug() << "Lagu" << songId << "berhasil ditambahkan ke playlist" << playlistName;
                    } else {
                        qDebug() << "Gagal menambah lagu ke playlist:" << patchReply->errorString()
                        << patchReply->readAll();
                    }
                    patchReply->deleteLater();
                });

                getReply->deleteLater();
            });
}

void DataManager::removeSongFromPlaylist(const QString &localId, const QString &idToken,
                                         const QString &playlistName, const QString &songId) {
    if (localId.isEmpty() || idToken.isEmpty() || playlistName.isEmpty() || songId.isEmpty()) return;

    QString playlistAman = QUrl::toPercentEncoding(playlistName);
    QString docUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists/%3")
                         .arg(projectId, localId, playlistAman);

    // Step 1: GET array lagu saat ini
    QNetworkRequest getRequest((QUrl(docUrl)));
    getRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *getReply = networkManager->get(getRequest);
    connect(getReply, &QNetworkReply::finished,
            [this, getReply, docUrl, idToken, playlistName, songId]() {

                if (getReply->error() != QNetworkReply::NoError) {
                    qDebug() << "Gagal GET playlist sebelum hapus lagu:" << getReply->errorString();
                    getReply->deleteLater();
                    return;
                }

                QJsonObject fields = QJsonDocument::fromJson(getReply->readAll())
                                         .object()["fields"].toObject();
                QJsonArray rawValues = fields["song_ids"].toObject()["arrayValue"]
                                           .toObject()["values"].toArray();

                // Step 2: Bangun array baru tanpa songId yang dihapus
                QJsonArray updatedArray;
                for (const QJsonValue &v : rawValues) {
                    QString id = v.toObject()["stringValue"].toString();
                    if (id != songId && !id.isEmpty() && id != "EMPTY_PLAYLIST") {
                        updatedArray.append(QJsonObject{{"stringValue", id}});
                    }
                }

                // Step 3: PATCH ke Firestore dengan array yang sudah diperbarui
                QString patchUrl = docUrl + "?updateMask.fieldPaths=song_ids";
                QNetworkRequest patchRequest((QUrl(patchUrl)));
                patchRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
                patchRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

                QJsonObject updatedFields;
                updatedFields["song_ids"] = QJsonObject{{"arrayValue", QJsonObject{{"values", updatedArray}}}};
                QJsonObject patchPayload;
                patchPayload["fields"] = updatedFields;

                QNetworkReply *patchReply = networkManager->sendCustomRequest(
                    patchRequest, "PATCH", QJsonDocument(patchPayload).toJson(QJsonDocument::Compact));

                connect(patchReply, &QNetworkReply::finished, [this, patchReply, songId, playlistName]() {
                    if (patchReply->error() == QNetworkReply::NoError) {
                        qDebug() << "Lagu" << songId << "berhasil dihapus dari playlist" << playlistName;
                        emit playlistSongRemoved(songId);
                    } else {
                        qDebug() << "Gagal hapus lagu:" << patchReply->errorString() << patchReply->readAll();
                    }
                    patchReply->deleteLater();
                });

                getReply->deleteLater();
            });
}

void DataManager::followArtist(const QString &localId, const QString &idToken, const QString &artistName) {
    if (localId.isEmpty() || idToken.isEmpty() || artistName.isEmpty()) return;

    QString namaArtisBersih = artistName.trimmed();
    QString artisAman = QUrl::toPercentEncoding(namaArtisBersih);

    QString alamatUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/followed/%3")
                            .arg(projectId, localId, artisAman);

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fields;
    // PERBAIKAN 1: Gunakan nama bersih agar di Firestore Console tulisannya normal dan rapi
    fields["artist_name"] = QJsonObject{{"stringValue", namaArtisBersih}};

    QJsonObject jsonPayload;
    jsonPayload["fields"] = fields;
    QByteArray payloadData = QJsonDocument(jsonPayload).toJson(QJsonDocument::Compact);

    // PERBAIKAN 2: Menggunakan PUT (Idempotent) lewat sendCustomRequest agar aman dan anti-double
    QNetworkReply *reply = networkManager->sendCustomRequest(request, "PATCH", payloadData);
    connect(reply, &QNetworkReply::finished, [reply, namaArtisBersih]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Berhasil mengikuti artis secara fisik di server (PUT):" << namaArtisBersih;
        } else {
            qDebug() << "Gagal follow artist via PUT:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::unfollowArtist(const QString &localId, const QString &idToken, const QString &artistName) {
    if (localId.isEmpty() || idToken.isEmpty() || artistName.isEmpty()) return;

    QString namaArtisBersih = artistName.trimmed();
    QString artisAman = QUrl::toPercentEncoding(namaArtisBersih);

    QString alamatUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/followed/%3")
                            .arg(projectId, localId, artisAman);

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->sendCustomRequest(request, "DELETE");
    connect(reply, &QNetworkReply::finished, [reply, namaArtisBersih]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Berhasil unfollow artis dari server:" << namaArtisBersih;
        } else {
            qDebug() << "Gagal menghapus dokumen artis:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::fetchFollowedArtists(const QString &localId, const QString &idToken) {
    if (localId.isEmpty() || idToken.isEmpty()) return;

    emit followedArtistClearRequested();

    QString alamatUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/followed")
                            .arg(projectId, localId);

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonArray documentsArray = jsonDoc.object()["documents"].toArray();

            for (const QJsonValue &docVal : documentsArray) {
                QJsonObject fields = docVal.toObject()["fields"].toObject();
                if (fields.contains("artist_name")) {
                    QString name = fields["artist_name"].toObject()["stringValue"].toString();
                    emit followedArtistFetched(name, "assets/artist_placeholder.png");
                }
            }
        } else {
            qDebug() << "Gagal mengambil data artis diikuti:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::fetchSongLrc(const QString &songId, const QString &idToken) {
    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/songs/%2")
                 .arg(projectId, songId));

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());
    QNetworkReply *reply = networkManager->get(request);

    connect(reply, &QNetworkReply::finished, [this, reply, songId, idToken]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject jsonObj = jsonDoc.object();
            QJsonObject fields = jsonObj["fields"].toObject();

            QString judulLagu = fields["title"].toObject()["stringValue"].toString();
            QString namaArtist = fields["artist"].toObject()["stringValue"].toString();
            QString imagePath = "";
            if (fields.contains("image_path")) {
                imagePath = fields["image_path"].toObject()["stringValue"].toString();
                if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
            }

            emit metadataFetched(judulLagu, namaArtist, imagePath);
            this->recordPlay(songId, idToken);
            QString mp3Path = fields["mp3_path"].toObject()["stringValue"].toString();
            if (mp3Path.contains("/blob/")) {
                mp3Path.replace("/blob/", "/raw/");
            }
            if (!mp3Path.isEmpty()) {
                this->playSong(mp3Path);
            }

            // 2. Ambil data lrc_path untuk memproses teks lirik
            QString lrcPath = fields["lrc_path"].toObject()["stringValue"].toString();
            if (lrcPath.contains("/blob/")) {
                lrcPath.replace("/blob/", "/raw/");
            }
            if (lrcPath.isEmpty()) {
                emit lrcFetched("Lirik lagu tidak tersedia.");
                reply->deleteLater();
                return;
            }

            // HTTP Request kedua untuk mengunduh konten file lirik .lrc dari Github Raw
            QNetworkRequest lrcRequest((QUrl(lrcPath)));
            QNetworkReply *lrcReply = networkManager->get(lrcRequest);
            connect(lrcReply, &QNetworkReply::finished, [this, lrcReply]() {
                if (lrcReply->error() == QNetworkReply::NoError) {
                    QString rawLrc = QString::fromUtf8(lrcReply->readAll());

                    // Kosongkan cache penyimpanan memori lirik lama
                    m_lyricList.clear();

                    // Potong lirik teks mentah per baris kalimat
                    QStringList lines = rawLrc.split('\n');

                    // Regex pencocokan format penanda waktu .lrc -> Contoh: [01:14.50]
                    QRegularExpression regex("\\[(\\d+):(\\d+)(?:\\.(\\d+))?\\](.*)");

                    for (const QString &line : lines) {
                        QString trimmedLine = line.trimmed();
                        QRegularExpressionMatch match = regex.match(trimmedLine);
                        if (match.hasMatch()) {
                            qint64 menit = match.captured(1).toLongLong();
                            qint64 detik = match.captured(2).toLongLong();
                            QString msStr = match.captured(3);
                            qint64 milidetik = 0;
                            if (!msStr.isEmpty()) {
                                // Normalisasi ke milidetik: "50" → 500ms, "5" → 500ms, "500" → 500ms
                                while (msStr.length() < 3) msStr += "0";
                                milidetik = msStr.left(3).toLongLong();
                            }
                            qint64 totalMs = (menit * 60 * 1000) + (detik * 1000) + milidetik;
                            QString teksLirikPerBaris = match.captured(4).trimmed();

                            // Masukkan ke penampung memori backend C++
                            m_lyricList.append({totalMs, teksLirikPerBaris});
                        }
                    }

                    // Tampilkan lirik baris paling pertama sebagai pembuka visual karaoke
                    if (!m_lyricList.isEmpty()) {
                        emit lrcFetched(rawLrc);
                    }

                } else {
                    emit lrcFetched("Gagal mengunduh teks lirik.");
                }
                lrcReply->deleteLater();
            });
        } else {
            qDebug() << "Koneksi Firestore gagal:" << reply->errorString();
            emit lrcFetched("Gagal menyambungkan ke database lagu.");
        }
        reply->deleteLater();
    });
}

void DataManager::replaySong() {
    m_mediaPlayer->setPosition(0);
    m_mediaPlayer->play();
}

void DataManager::stopSong() {
    if (m_mediaPlayer) m_mediaPlayer->stop();
}

void DataManager::playSong(const QString &mp3Url) {
    if (!mp3Url.isEmpty() && m_mediaPlayer) {
        m_mediaPlayer->setSource(QUrl(mp3Url));
        m_audioOutput->setVolume(0.8); // Pasang volume awal audio di 80%
        m_mediaPlayer->play();
        qDebug() << "Memulai pemutaran audio streaming dari:" << mp3Url;
    }
}

void DataManager::pauseSong() {
    if (m_mediaPlayer) m_mediaPlayer->pause();
}

void DataManager::resumeSong() {
    if (m_mediaPlayer) m_mediaPlayer->play();
}

void DataManager::updateLyricPosition(qint64 currentPositionMs) {
    if (m_lyricList.isEmpty()) return;

    emit audioPositionChanged(currentPositionMs, m_mediaPlayer->duration());

    int activeIndex = 0;
    for (int i = 0; i < m_lyricList.size(); ++i) {
        if (currentPositionMs >= m_lyricList[i].timeMs) {
            activeIndex = i;
        } else {
            break;
        }
    }

    if (activeIndex != m_lastActiveLyricIndex) {
        m_lastActiveLyricIndex = activeIndex;
        emit activeLyricIndexChanged(activeIndex);
    }
}

void DataManager::fetchLatestSongsBanner(const QString &idToken) {
    QString alamatUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents:runQuery")
    .arg(projectId);

    QUrl url(alamatUrl);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fromObj;
    fromObj["collectionId"] = "songs";

    QJsonObject fieldRef;
    fieldRef["fieldPath"] = "release_date";

    QJsonObject orderObj;
    orderObj["field"] = fieldRef;
    orderObj["direction"] = "DESCENDING";

    QJsonObject structuredQuery;
    structuredQuery["from"]    = QJsonArray{fromObj};
    structuredQuery["orderBy"] = QJsonArray{orderObj};
    structuredQuery["limit"]   = 5;

    QJsonObject payload;
    payload["structuredQuery"] = structuredQuery;

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(payload).toJson());
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonArray results = QJsonDocument::fromJson(reply->readAll()).array();
            if (results.isEmpty()) {
                qDebug() << "Banner: array dokumen kosong.";
                reply->deleteLater();
                return;
            }

            emit bannerClearRequested();

            QSet<QString> seenIds;
            for (const QJsonValue &value : results) {
                QJsonObject resultObj = value.toObject();
                if (!resultObj.contains("document")) continue;

                QJsonObject docObj = resultObj["document"].toObject();
                if (docObj.isEmpty()) continue;

                QString songId = docObj["name"].toString().split("/").last();

                if (songId.isEmpty() || seenIds.contains(songId)) continue;
                seenIds.insert(songId);

                QJsonObject fields = docObj["fields"].toObject();
                QString title     = fields.contains("title")  ? fields["title"].toObject()["stringValue"].toString()  : "Unknown Title";
                QString artist    = fields.contains("artist") ? fields["artist"].toObject()["stringValue"].toString() : "Unknown Artist";
                QString imagePath = "";
                if (fields.contains("image_path")) {
                    imagePath = fields["image_path"].toObject()["stringValue"].toString();
                    if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
                }
                emit latestSongBannerFetched(songId, title, artist, imagePath);
            }
        } else {
            qDebug() << "Gagal memuat banner:" << reply->errorString();
            qDebug() << reply->readAll();
        }
        reply->deleteLater();
    });
}

void DataManager::fetchSongsInPlaylist(const QString &localId, const QString &idToken, const QString &playlistName) {
    emit playlistSongsClearRequested();

    QString playlistAman = QUrl::toPercentEncoding(playlistName);

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/playlists/%3")
                   .arg(projectId, localId, playlistAman));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);

    connect(reply, &QNetworkReply::finished, [this, reply, idToken]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject jsonObj = jsonDoc.object();
            QJsonObject fields = jsonObj["fields"].toObject();

            QJsonObject songIdsObj = fields["song_ids"].toObject();
            QJsonArray valuesArray = songIdsObj["arrayValue"].toObject()["values"].toArray();

            for (const QJsonValue &val : valuesArray) {
                QString songId = val.toObject()["stringValue"].toString();

                if (songId == "EMPTY_PLAYLIST" || songId.isEmpty()) {
                    continue;
                }
                QUrl urlLagu(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/songs/%2")
                                   .arg(projectId, songId));

                QNetworkRequest reqLagu(urlLagu);
                reqLagu.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

                QNetworkReply *replyLagu = networkManager->get(reqLagu);

                connect(replyLagu, &QNetworkReply::finished, [this, replyLagu, songId]() {
                    if (replyLagu->error() == QNetworkReply::NoError) {
                        QJsonDocument docLagu = QJsonDocument::fromJson(replyLagu->readAll());
                        QJsonObject fieldsLagu = docLagu.object()["fields"].toObject();

                        QString title = fieldsLagu.contains("title") ? fieldsLagu["title"].toObject()["stringValue"].toString() : "Unknown Title";
                        QString artist = fieldsLagu.contains("artist") ? fieldsLagu["artist"].toObject()["stringValue"].toString() : "Unknown Artist";

                        QString imagePath = "";
                        if (fieldsLagu.contains("image_path")) {
                            imagePath = fieldsLagu["image_path"].toObject()["stringValue"].toString();
                            if (imagePath.contains("/blob/")) {
                                imagePath.replace("/blob/", "/raw/");
                            }
                        }

                        emit playlistSongItemFetched(songId, title, artist, imagePath);
                    }
                    replyLagu->deleteLater();
                });
            }
        } else {
            qDebug() << "Gagal memuat daftar isi playlist dari Firestore:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::checkIfFollowing(const QString &localId, const QString &idToken, const QString &artistName) {
    if (localId.isEmpty() || idToken.isEmpty() || artistName.isEmpty()) {
        emit followStatusChecked(false);
        return;
    }

    QString artisAman = QUrl::toPercentEncoding(artistName.trimmed());
    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/followed/%3")
                 .arg(projectId, localId, artisAman));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        // 200 = dokumen artis ada = sudah diikuti, 404 = belum
        emit followStatusChecked(reply->error() == QNetworkReply::NoError);
        reply->deleteLater();
    });
}

void DataManager::fetchSongsByArtist(const QString &idToken, const QString &artistName) {
    emit playlistSongsClearRequested(); // reuse signal yang sama agar HalamanKategori otomatis clear

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents:runQuery")
                 .arg(projectId));

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fieldFilter;
    fieldFilter["field"]  = QJsonObject{{"fieldPath", "artist"}};
    fieldFilter["op"]     = "EQUAL";
    fieldFilter["value"]  = QJsonObject{{"stringValue", artistName}};

    QJsonObject structuredQuery;
    structuredQuery["from"]  = QJsonArray{QJsonObject{{"collectionId", "songs"}}};
    structuredQuery["where"] = QJsonObject{{"fieldFilter", fieldFilter}};

    QJsonObject payload;
    payload["structuredQuery"] = structuredQuery;

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(payload).toJson());
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonArray results = QJsonDocument::fromJson(reply->readAll()).array();
            for (const QJsonValue &value : results) {
                QJsonObject resultObj = value.toObject();
                if (!resultObj.contains("document")) continue;

                QJsonObject docObj = resultObj["document"].toObject();
                QString songId    = docObj["name"].toString().split("/").last();
                QJsonObject fields = docObj["fields"].toObject();

                QString title  = fields.contains("title")  ? fields["title"].toObject()["stringValue"].toString()  : "Unknown";
                QString artist = fields.contains("artist") ? fields["artist"].toObject()["stringValue"].toString() : "Unknown";
                QString imagePath = "";
                if (fields.contains("image_path")) {
                    imagePath = fields["image_path"].toObject()["stringValue"].toString();
                    if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
                }

                emit playlistSongItemFetched(songId, title, artist, imagePath);
            }
        } else {
            qDebug() << "Gagal fetch lagu by artist:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::addToFavorites(const QString &localId, const QString &idToken, const QString &songId) {
    if (localId.isEmpty() || idToken.isEmpty() || songId.isEmpty()) return;

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/favorites/%3")
                 .arg(projectId, localId, songId));

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fields;
    fields["song_id"] = QJsonObject{{"stringValue", songId}};
    QJsonObject payload;
    payload["fields"] = fields;

    QNetworkReply *reply = networkManager->sendCustomRequest(request, "PATCH", QJsonDocument(payload).toJson());
    connect(reply, &QNetworkReply::finished, [reply, songId]() {
        if (reply->error() == QNetworkReply::NoError)
            qDebug() << "Lagu ditambah ke favorit:" << songId;
        else
            qDebug() << "Gagal tambah favorit:" << reply->errorString();
        reply->deleteLater();
    });
}

void DataManager::removeFromFavorites(const QString &localId, const QString &idToken, const QString &songId) {
    if (localId.isEmpty() || idToken.isEmpty() || songId.isEmpty()) return;

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/favorites/%3")
                 .arg(projectId, localId, songId));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->sendCustomRequest(request, "DELETE");
    connect(reply, &QNetworkReply::finished, [reply, songId]() {
        if (reply->error() == QNetworkReply::NoError)
            qDebug() << "Lagu dihapus dari favorit:" << songId;
        reply->deleteLater();
    });
}

void DataManager::checkIfFavorite(const QString &localId, const QString &idToken, const QString &songId) {
    if (localId.isEmpty() || idToken.isEmpty() || songId.isEmpty()) {
        emit favoriteStatusChecked(false);
        return;
    }

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/favorites/%3")
                 .arg(projectId, localId, songId));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        emit favoriteStatusChecked(reply->error() == QNetworkReply::NoError);
        reply->deleteLater();
    });
}

void DataManager::fetchFavoriteSongs(const QString &localId, const QString &idToken) {
    emit playlistSongsClearRequested();

    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/users/%2/favorites")
                 .arg(projectId, localId));

    QNetworkRequest request(url);
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, [this, reply, idToken]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonArray documents = QJsonDocument::fromJson(reply->readAll()).object()["documents"].toArray();

            for (const QJsonValue &docVal : documents) {
                QJsonObject fields = docVal.toObject()["fields"].toObject();
                QString songId = fields["song_id"].toObject()["stringValue"].toString();
                if (songId.isEmpty()) continue;

                QUrl urlLagu(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/songs/%2")
                                 .arg(projectId, songId));
                QNetworkRequest reqLagu(urlLagu);
                reqLagu.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

                QNetworkReply *replyLagu = networkManager->get(reqLagu);
                connect(replyLagu, &QNetworkReply::finished, [this, replyLagu, songId]() {
                    if (replyLagu->error() == QNetworkReply::NoError) {
                        QJsonObject fieldsLagu = QJsonDocument::fromJson(replyLagu->readAll()).object()["fields"].toObject();

                        QString title  = fieldsLagu.contains("title")  ? fieldsLagu["title"].toObject()["stringValue"].toString()  : "Unknown";
                        QString artist = fieldsLagu.contains("artist") ? fieldsLagu["artist"].toObject()["stringValue"].toString() : "Unknown";
                        QString imagePath = "";
                        if (fieldsLagu.contains("image_path")) {
                            imagePath = fieldsLagu["image_path"].toObject()["stringValue"].toString();
                            if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
                        }

                        emit playlistSongItemFetched(songId, title, artist, imagePath);
                    }
                    replyLagu->deleteLater();
                });
            }
        } else {
            qDebug() << "Gagal fetch favorit:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::fetchSeringDiputar(const QString &idToken) {
    QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents:runQuery")
                 .arg(projectId));

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QJsonObject fieldFilter;
    fieldFilter["field"]  = QJsonObject{{"fieldPath", "count"}};
    fieldFilter["op"]     = "GREATER_THAN";
    fieldFilter["value"]  = QJsonObject{{"integerValue", "0"}};

    QJsonObject structuredQuery;
    structuredQuery["from"]    = QJsonArray{QJsonObject{{"collectionId", "play_counts"}}};
    structuredQuery["where"]   = QJsonObject{{"fieldFilter", fieldFilter}};
    structuredQuery["orderBy"] = QJsonArray{QJsonObject{
        {"field", QJsonObject{{"fieldPath", "count"}}},
        {"direction", "DESCENDING"}
    }};
    structuredQuery["limit"] = 10;

    QJsonObject payload;
    payload["structuredQuery"] = structuredQuery;

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(payload).toJson());
    connect(reply, &QNetworkReply::finished, [this, reply, idToken]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonArray results = QJsonDocument::fromJson(reply->readAll()).array();

            emit seringDiputarClearRequested();

            QList<QString> uniqueIds;
            QSet<QString> seenIds;

            for (const QJsonValue &value : results) {
                QJsonObject resultObj = value.toObject();
                if (!resultObj.contains("document")) continue;
                QString songId = resultObj["document"].toObject()["name"].toString().split("/").last();
                if (songId.isEmpty() || seenIds.contains(songId)) continue;
                seenIds.insert(songId);
                uniqueIds.append(songId);
            }

            for (const QString &songId : uniqueIds) {
                QUrl urlLagu(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/songs/%2")
                                 .arg(projectId, songId));
                QNetworkRequest reqLagu(urlLagu);
                reqLagu.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

                QNetworkReply *replyLagu = networkManager->get(reqLagu);
                connect(replyLagu, &QNetworkReply::finished, [this, replyLagu, songId]() {
                    if (replyLagu->error() == QNetworkReply::NoError) {
                        QJsonObject fields = QJsonDocument::fromJson(replyLagu->readAll()).object()["fields"].toObject();
                        QString title     = fields.contains("title")  ? fields["title"].toObject()["stringValue"].toString()  : "Unknown";
                        QString artist    = fields.contains("artist") ? fields["artist"].toObject()["stringValue"].toString() : "Unknown";
                        QString imagePath = "";
                        if (fields.contains("image_path")) {
                            imagePath = fields["image_path"].toObject()["stringValue"].toString();
                            if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
                        }
                        emit seringDiputarItemFetched(songId, title, artist, imagePath);
                    }
                    replyLagu->deleteLater();
                });
            }
        } else {
            qDebug() << "Gagal fetch sering diputar:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void DataManager::recordPlay(const QString &songId, const QString &idToken) {
    if (songId.isEmpty() || idToken.isEmpty()) return;

    QString docUrl = QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents/play_counts/%2")
                         .arg(projectId, songId);

    // Step 1: GET nilai count saat ini
    QNetworkRequest getRequest((QUrl(docUrl)));
    getRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

    QNetworkReply *getReply = networkManager->get(getRequest);
    connect(getReply, &QNetworkReply::finished, [this, getReply, docUrl, songId, idToken]() {
        qint64 currentCount = 0;

        if (getReply->error() == QNetworkReply::NoError) {
            QJsonObject fields = QJsonDocument::fromJson(getReply->readAll()).object()["fields"].toObject();
            if (fields.contains("count")) {
                currentCount = fields["count"].toObject()["integerValue"].toString().toLongLong();
            }
        }

        QNetworkRequest patchRequest((QUrl(docUrl)));
        patchRequest.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        patchRequest.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

        QJsonObject fields;
        fields["count"] = QJsonObject{{"integerValue", QString::number(currentCount + 1)}};
        QJsonObject patchPayload;
        patchPayload["fields"] = fields;

        QNetworkReply *patchReply = networkManager->sendCustomRequest(
            patchRequest, "PATCH", QJsonDocument(patchPayload).toJson());

        connect(patchReply, &QNetworkReply::finished, [patchReply, songId]() {
            if (patchReply->error() == QNetworkReply::NoError)
                qDebug() << "Play count berhasil dicatat:" << songId;
            else
                qDebug() << "Gagal catat play:" << patchReply->errorString() << patchReply->readAll();
            patchReply->deleteLater();
        });

        getReply->deleteLater();
    });
}

void DataManager::fetchSearchResults(const QString &idToken, const QString &query, const QString &filterType, int limit) {
    if (query.trimmed().isEmpty()) {
        emit searchResultClearRequested();
        return;
    }

    QString fieldPath = (filterType == "artis") ? "artist" : "title";

    // Jalankan query untuk 2 variasi huruf:
    // 1. huruf kecil semua  → "adele"
    // 2. huruf kapital awal → "Adele"
    QStringList variants;
    QString lower  = query.toLower();
    QString titled = query.left(1).toUpper() + query.mid(1).toLower();
    variants << lower;
    if (titled != lower) variants << titled;

    // Shared state agar hasil dari kedua query bisa di-dedup
    auto seenIds = std::make_shared<QSet<QString>>();

    emit searchResultClearRequested();

    for (const QString &q : variants) {
        QString queryEnd = q + "\uf8ff";

        QUrl url(QString("https://firestore.googleapis.com/v1/projects/%1/databases/(default)/documents:runQuery")
                     .arg(projectId));
        QNetworkRequest request(url);
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        request.setRawHeader("Authorization", QString("Bearer %1").arg(idToken).toUtf8());

        QJsonObject filterStart;
        filterStart["field"] = QJsonObject{{"fieldPath", fieldPath}};
        filterStart["op"]    = "GREATER_THAN_OR_EQUAL";
        filterStart["value"] = QJsonObject{{"stringValue", q}};

        QJsonObject filterEnd;
        filterEnd["field"] = QJsonObject{{"fieldPath", fieldPath}};
        filterEnd["op"]    = "LESS_THAN";
        filterEnd["value"] = QJsonObject{{"stringValue", queryEnd}};

        QJsonObject compositeFilter;
        compositeFilter["op"] = "AND";
        compositeFilter["filters"] = QJsonArray{
            QJsonObject{{"fieldFilter", filterStart}},
            QJsonObject{{"fieldFilter", filterEnd}}
        };

        QJsonObject structuredQuery;
        structuredQuery["from"]    = QJsonArray{QJsonObject{{"collectionId", "songs"}}};
        structuredQuery["where"]   = QJsonObject{{"compositeFilter", compositeFilter}};
        structuredQuery["orderBy"] = QJsonArray{
            QJsonObject{{"field", QJsonObject{{"fieldPath", fieldPath}}}, {"direction", "ASCENDING"}}
        };
        if (limit > 0) structuredQuery["limit"] = limit;

        QJsonObject payload;
        payload["structuredQuery"] = structuredQuery;

        QNetworkReply *reply = networkManager->post(request, QJsonDocument(payload).toJson());
        connect(reply, &QNetworkReply::finished, [this, reply, seenIds]() {
            if (reply->error() == QNetworkReply::NoError) {
                QJsonArray results = QJsonDocument::fromJson(reply->readAll()).array();

                for (const QJsonValue &value : results) {
                    QJsonObject resultObj = value.toObject();
                    if (!resultObj.contains("document")) continue;

                    QJsonObject docObj = resultObj["document"].toObject();
                    QJsonObject fields = docObj["fields"].toObject();
                    QString songId = docObj["name"].toString().split("/").last();

                    // Skip kalau songId sudah muncul dari query lain
                    if (songId.isEmpty() || seenIds->contains(songId)) continue;
                    seenIds->insert(songId);

                    QString title     = fields.contains("title")  ? fields["title"].toObject()["stringValue"].toString()  : "Unknown";
                    QString artist    = fields.contains("artist") ? fields["artist"].toObject()["stringValue"].toString() : "Unknown";
                    QString imagePath = "";
                    if (fields.contains("image_path")) {
                        imagePath = fields["image_path"].toObject()["stringValue"].toString();
                        if (imagePath.contains("/blob/")) imagePath.replace("/blob/", "/raw/");
                    }

                    emit searchResultItemFetched(songId, title, artist, imagePath);
                }
            } else {
                qDebug() << "Gagal fetch hasil pencarian:" << reply->errorString();
            }
            reply->deleteLater();
        });
    }
}



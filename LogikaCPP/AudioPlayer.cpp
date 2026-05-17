#include "AudioPlayer.h"
#include <QFile>
#include <QDir>
#include <QFileInfo>
#include <QStandardPaths>
#include <QNetworkRequest>

AudioPlayer::AudioPlayer(QObject* parent) : QObject(parent) {
    m_player = new QMediaPlayer(this);
    m_audio  = new QAudioOutput(this);
    m_net    = new QNetworkAccessManager(this);
    m_timer  = new QTimer(this);

    m_player->setAudioOutput(m_audio);
    m_audio->setVolume(1.0f);
    m_timer->setInterval(50);

    connect(m_timer,  &QTimer::timeout,                      this, &AudioPlayer::onTick);
    connect(m_player, &QMediaPlayer::durationChanged,        this, [this](qint64){ emit durationBerubah(); });
    connect(m_player, &QMediaPlayer::playbackStateChanged,   this, &AudioPlayer::onState);
    connect(m_player, &QMediaPlayer::mediaStatusChanged,     this, &AudioPlayer::onMedia);

    setStatus("Siap");
}

void AudioPlayer::resetLirik() {
    m_lirik.clear(); m_idx = -1;
    m_aktif = m_sebelum = m_sesudah = "";
    emit lirikBerubah();
}

void AudioPlayer::setOffsetLirik(int ms) {
    m_offset = ms; m_idx = -1;
    emit offsetBerubah();
}

void AudioPlayer::putarDariUrl(const QString& urlAudio, const QString& urlLirik) {
    setStatus("Memuat...");
    resetLirik();
    m_player->setSource(QUrl(urlAudio));
    if (!urlLirik.isEmpty()) muatLirikUrl(urlLirik);
}

void AudioPlayer::putarDariLokal(const QString& path, const QString& pathLirik) {
    setStatus("Memuat...");
    resetLirik();
    m_player->setSource(QUrl::fromLocalFile(path));

    QString lp = pathLirik;
    if (lp.isEmpty()) {
        QFileInfo fi(path);
        for (auto& ext : {"lrc","srt","txt"}) {
            QString c = fi.absolutePath() + "/" + fi.baseName() + "." + ext;
            if (QFile::exists(c)) { lp = c; break; }
        }
    }
    if (!lp.isEmpty()) muatLirikFile(lp);
    putar();
}

void AudioPlayer::putar() {
    m_player->play(); m_timer->start();
    m_bunyi = true; emit statusBerubah();
}

void AudioPlayer::jeda() {
    m_player->pause(); m_timer->stop();
    m_bunyi = false; emit statusBerubah();
}

void AudioPlayer::togglePutarJeda() {
    m_bunyi ? jeda() : putar();
}

void AudioPlayer::lompat(qint64 ms) {
    m_player->setPosition(ms); m_idx = -1;
}

void AudioPlayer::lompatFraksi(double f) {
    lompat((qint64)(f * m_player->duration()));
}

void AudioPlayer::muatLirikFile(const QString& path) {
    QString ext = QFileInfo(path).suffix().toLower();
    if      (ext == "lrc") m_lirik = bacaLRC(path, &m_info);
    else if (ext == "srt") m_lirik = bacaSRT(path);
    else                   m_lirik = bacaTXT(path);
    m_idx = -1;
    setStatus(m_lirik.isEmpty() ? "Lirik kosong" : QString::number(m_lirik.size()) + " baris");
    emit infoLaguBerubah(); emit lirikBerubah();
}

void AudioPlayer::muatLirikUrl(const QString& url) {
    QNetworkRequest req(QUrl(url));
    req.setAttribute(QNetworkRequest::RedirectPolicyAttribute,
                     QNetworkRequest::NoLessSafeRedirectPolicy);
    auto* r = m_net->get(req);
    connect(r, &QNetworkReply::finished, [this, r]() { onLirikDapat(r); });
}

void AudioPlayer::onLirikDapat(QNetworkReply* r) {
    if (r->error() != QNetworkReply::NoError) {
        setStatus("Gagal: " + r->errorString());
        r->deleteLater(); return;
    }
    QString isi = QString::fromUtf8(r->readAll());
    QString url = r->request().url().toString();
    r->deleteLater();

    if (url.endsWith(".srt")) {
        QString tmp = QStandardPaths::writableLocation(QStandardPaths::TempLocation) + "/tmp.srt";
        QFile f(tmp);
        if (f.open(QIODevice::WriteOnly)) { f.write(isi.toUtf8()); f.close(); }
        m_lirik = bacaSRT(tmp);
    } else {
        m_lirik = parseStringLRC(isi, &m_info);
        if (m_lirik.isEmpty()) {
            qint64 t = 0;
            for (auto& b : isi.split('\n')) {
                QString s = b.trimmed();
                if (!s.isEmpty()) { m_lirik.push_back({t, s}); t += 3000; }
            }
        }
    }
    m_idx = -1;
    setStatus(QString::number(m_lirik.size()) + " baris lirik");
    emit infoLaguBerubah(); emit lirikBerubah();
}

void AudioPlayer::onTick() {
    if (!m_lirik.isEmpty()) syncLirik(m_player->position());
    emit posisiBerubah();
}

void AudioPlayer::syncLirik(qint64 pos) {
    qint64 p = pos - m_offset;
    int idx = -1;
    for (int i = 0; i < m_lirik.size(); i++) {
        if (p >= m_lirik[i].waktu_ms) idx = i;
        else break;
    }
    if (idx == m_idx) return;
    m_idx = idx;

    if (idx < 0) {
        m_aktif = m_sebelum = "";
        m_sesudah = m_lirik.isEmpty() ? "" : m_lirik[0].teks;
    } else {
        m_aktif   = m_lirik[idx].teks;
        m_sebelum = idx > 0 ? m_lirik[idx-1].teks : "";
        m_sesudah = idx+1 < m_lirik.size() ? m_lirik[idx+1].teks : "";
    }
    emit lirikBerubah();
}

QString AudioPlayer::formatWaktu(qint64 ms) const {
    int s = (int)(ms / 1000);
    return QString("%1:%2").arg(s/60).arg(s%60, 2, 10, QChar('0'));
}

void AudioPlayer::onState(QMediaPlayer::PlaybackState s) {
    m_bunyi = (s == QMediaPlayer::PlayingState);
    if (s == QMediaPlayer::StoppedState) { m_timer->stop(); setStatus("Selesai"); }
    emit statusBerubah();
}

void AudioPlayer::onMedia(QMediaPlayer::MediaStatus s) {
    if (s == QMediaPlayer::LoadingMedia)  setStatus("Memuat...");
    if (s == QMediaPlayer::BufferingMedia) setStatus("Buffering...");
    if (s == QMediaPlayer::LoadedMedia || s == QMediaPlayer::BufferedMedia) {
        setStatus("Siap"); putar();
    }
    if (s == QMediaPlayer::InvalidMedia) setStatus("File tidak valid");
}

void AudioPlayer::setStatus(const QString& t) {
    m_status = t; emit pesanStatusBerubah();
}


#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

// 1. TAMBAHAN: Library pendukung untuk audio player dan pemotong lirik
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QList>

// Struktur data untuk menyimpan pasangan waktu dan baris teks lirik
struct LyricLine {
    qint64 timeMs;
    QString text;
};

class DataManager : public QObject {
    Q_OBJECT
public:
    explicit DataManager(QObject *parent = nullptr);

    // Q_INVOKABLE ditambahkan agar fungsi-fungsi ini bisa dipanggil langsung dari sisi UI QML
    Q_INVOKABLE void initializeUserCollections(const QString &localId, const QString &idToken);
    Q_INVOKABLE void createUserPlaylist(const QString &localId, const QString &idToken, const QString &playlistName);
    Q_INVOKABLE void addSongToPlaylist(const QString &localId, const QString &idToken, const QString &playlistName, const QString &songId);
    Q_INVOKABLE void followArtist(const QString &localId, const QString &idToken, const QString &artistName);
    Q_INVOKABLE void unfollowArtist(const QString &localId, const QString &idToken, const QString &artistName);
    Q_INVOKABLE void fetchFollowedArtists(const QString &localId, const QString &idToken);
    Q_INVOKABLE void fetchUserPlaylists(const QString &localId, const QString &idToken);
    Q_INVOKABLE void deleteUserPlaylist(const QString &localId, const QString &idToken, const QString &playlistName);
    Q_INVOKABLE void removeSongFromPlaylist(const QString &localId, const QString &idToken, const QString &playlistName, const QString &songId);

    // Fungsi pembaca lirik dari Firebase & GitHub
    Q_INVOKABLE void fetchSongLrc(const QString &songId, const QString &idToken);
    Q_INVOKABLE void replaySong();

    // 2. TAMBAHAN: Fungsi kontrol lagu yang bisa diklik dari tombol QML
    Q_INVOKABLE void pauseSong();
    Q_INVOKABLE void resumeSong();
    Q_INVOKABLE void fetchLatestSongsBanner(const QString &idToken);
    Q_INVOKABLE void fetchSongsInPlaylist(const QString &localId, const QString &idToken, const QString &playlistName);
    Q_INVOKABLE void fetchSongsByArtist(const QString &idToken, const QString &artistName);

    Q_INVOKABLE void checkIfFollowing(const QString &localId, const QString &idToken, const QString &artistName);

    Q_INVOKABLE void addToFavorites(const QString &localId, const QString &idToken, const QString &songId);
    Q_INVOKABLE void removeFromFavorites(const QString &localId, const QString &idToken, const QString &songId);

    Q_INVOKABLE void checkIfFavorite(const QString &localId, const QString &idToken, const QString &songId);
    Q_INVOKABLE void fetchFavoriteSongs(const QString &localId, const QString &idToken);
    Q_INVOKABLE void fetchSeringDiputar(const QString &idToken);
    Q_INVOKABLE void recordPlay(const QString &songId, const QString &idToken);
    Q_INVOKABLE void stopSong();

    Q_INVOKABLE void fetchSearchResults(const QString &idToken, const QString &query, const QString &filterType = "lagu", int limit = 3);

signals:
    // Signal untuk mengirim data nama playlist ke QML setelah sukses di-fetch
    void playlistFetched(const QString &playlistName, const QString &songCountInfo);
    void playlistDeleted(const QString &playlistName);
    void latestSongBannerFetched(const QString &songId, const QString &title, const QString &artist, const QString &imagePath);

    // Signal ini akan mengirimkan lirik aktif baris demi baris ke QML Anda
    void lrcFetched(const QString &lrcRawText);
    void activeLyricIndexChanged(int index);

    void metadataFetched(const QString &title, const QString &artist, const QString &imagePath);
    void audioPositionChanged(qint64 positionMs, qint64 durationMs);

    void playlistSongsClearRequested();
    void playlistSongItemFetched(const QString &songId, const QString &title, const QString &artist, const QString &imagePath);
    void seringDiputarItemFetched(const QString &songId, const QString &title, const QString &artist, const QString &imagePath);

    void followedArtistClearRequested();
    void followedArtistFetched(const QString &artistName, const QString &artistImg);

    void followStatusChecked(bool isFollowed);
    void favoriteStatusChecked(bool isFavorite);

    void seringDiputarClearRequested();
    void bannerClearRequested();

    void searchResultClearRequested();
    void searchResultItemFetched(const QString &songId, const QString &title, const QString &artist, const QString &imagePath);

    void playlistFetchStarted();
    void playlistSongRemoved(const QString &songId);

public slots:
    // 3. TAMBAHAN: Slot otomatis untuk mencocokkan detik lagu berjalan dengan teks lirik
    void updateLyricPosition(qint64 currentPositionMs);

private:
    QNetworkAccessManager *networkManager;
    QString projectId = "justplayapp";

    // 4. TAMBAHAN: Pointer objek multimedia Qt6
    QMediaPlayer *m_mediaPlayer = nullptr;
    QAudioOutput *m_audioOutput = nullptr;

    // Kontainer memori untuk menampung seluruh teks lirik lagu yang sudah dipotong
    QList<LyricLine> m_lyricList;

    // Fungsi internal untuk memutar file MP3 streaming
    void playSong(const QString &mp3Url);

    int m_lastActiveLyricIndex = -1;
};

#endif // DATAMANAGER_H

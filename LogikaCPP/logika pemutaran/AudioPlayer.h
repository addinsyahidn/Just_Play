#pragma once
#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QTimer>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include "LrcParser.h"

class AudioPlayer : public QObject {
    Q_OBJECT

    Q_PROPERTY(bool    sedangBunyi   READ sedangBunyi   NOTIFY statusBerubah)
    Q_PROPERTY(qint64  posisi        READ posisi        NOTIFY posisiBerubah)
    Q_PROPERTY(qint64  durasi        READ durasi        NOTIFY durationBerubah)
    Q_PROPERTY(QString lirikAktif    READ lirikAktif    NOTIFY lirikBerubah)
    Q_PROPERTY(QString lirikSebelum  READ lirikSebelum  NOTIFY lirikBerubah)
    Q_PROPERTY(QString lirikSesudah  READ lirikSesudah  NOTIFY lirikBerubah)
    Q_PROPERTY(QString judulLagu     READ judulLagu     NOTIFY infoLaguBerubah)
    Q_PROPERTY(QString namaPenyanyi  READ namaPenyanyi  NOTIFY infoLaguBerubah)
    Q_PROPERTY(QString pesanStatus   READ pesanStatus   NOTIFY pesanStatusBerubah)
    Q_PROPERTY(int     offsetLirik   READ offsetLirik   WRITE setOffsetLirik NOTIFY offsetBerubah)

public:
    explicit AudioPlayer(QObject* parent = nullptr);

    bool    sedangBunyi()  const { return m_bunyi; }
    qint64  posisi()       const { return m_player->position(); }
    qint64  durasi()       const { return m_player->duration(); }
    QString lirikAktif()   const { return m_aktif; }
    QString lirikSebelum() const { return m_sebelum; }
    QString lirikSesudah() const { return m_sesudah; }
    QString judulLagu()    const { return m_info.judul; }
    QString namaPenyanyi() const { return m_info.penyanyi; }
    QString pesanStatus()  const { return m_status; }
    int     offsetLirik()  const { return m_offset; }
    void    setOffsetLirik(int ms);

    Q_INVOKABLE void putarDariUrl(const QString& urlAudio, const QString& urlLirik = "");
    Q_INVOKABLE void putarDariLokal(const QString& path, const QString& pathLirik = "");
    Q_INVOKABLE void putar();
    Q_INVOKABLE void jeda();
    Q_INVOKABLE void togglePutarJeda();
    Q_INVOKABLE void lompat(qint64 ms);
    Q_INVOKABLE void lompatFraksi(double f);
    Q_INVOKABLE void muatLirikUrl(const QString& url);
    Q_INVOKABLE void muatLirikFile(const QString& path);
    Q_INVOKABLE QString formatWaktu(qint64 ms) const;

signals:
    void statusBerubah();
    void posisiBerubah();
    void durationBerubah();
    void lirikBerubah();
    void infoLaguBerubah();
    void pesanStatusBerubah();
    void offsetBerubah();

private slots:
    void onTick();
    void onState(QMediaPlayer::PlaybackState s);
    void onMedia(QMediaPlayer::MediaStatus s);
    void onLirikDapat(QNetworkReply* r);

private:
    void syncLirik(qint64 pos);
    void setStatus(const QString& t);
    void resetLirik();

    QMediaPlayer*          m_player;
    QAudioOutput*          m_audio;
    QNetworkAccessManager* m_net;
    QTimer*                m_timer;

    QVector<BariLirik> m_lirik;
    InfoLagu           m_info;
    int  m_idx    = -1;
    int  m_offset = 0;
    bool m_bunyi  = false;

    QString m_aktif, m_sebelum, m_sesudah, m_status;
};


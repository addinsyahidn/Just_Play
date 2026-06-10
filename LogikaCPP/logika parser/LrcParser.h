#pragma once
#include <QString>
#include <QVector>

struct BariLirik {
    qint64  waktu_ms;
    QString teks;
};

struct InfoLagu {
    QString judul, penyanyi, album;
    int offset_ms = 0;
};

QVector<BariLirik> bacaLRC(const QString& path, InfoLagu* info = nullptr);
QVector<BariLirik> bacaSRT(const QString& path);
QVector<BariLirik> bacaTXT(const QString& path);
QVector<BariLirik> parseStringLRC(const QString& isi, InfoLagu* info = nullptr);

qint64 lrcKeMs(const QString& t);
qint64 srtKeMs(const QString& t);


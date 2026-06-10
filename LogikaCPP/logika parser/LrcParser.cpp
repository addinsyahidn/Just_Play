#include "LrcParser.h"
#include <QFile>
#include <QTextStream>
#include <QFileInfo>
#include <QRegularExpression>
#include <algorithm>

QVector<BariLirik> parseStringLRC(const QString& isi, InfoLagu* info) {
    QVector<BariLirik> hasil;
    InfoLagu meta;

    QRegularExpression rwaktu(R"(\[(\d{1,2}:\d{2}[.:]\d{2,3})\])");
    QRegularExpression rmeta(R"(\[(\w+):([^\]]+)\])");

    for (QString baris : isi.split('\n')) {
        baris = baris.trimmed();
        if (baris.isEmpty()) continue;

        auto mm = rmeta.match(baris);
        if (mm.hasMatch() && !rwaktu.match(baris).hasMatch()) {
            QString k = mm.captured(1).toLower(), v = mm.captured(2).trimmed();
            if      (k == "ti")     meta.judul    = v;
            else if (k == "ar")     meta.penyanyi = v;
            else if (k == "al")     meta.album    = v;
            else if (k == "offset") meta.offset_ms = v.toInt();
            continue;
        }

        QVector<qint64> waktuList;
        auto it = rwaktu.globalMatch(baris);
        int akhir = 0;
        while (it.hasNext()) {
            auto m = it.next();
            waktuList.push_back(lrcKeMs(m.captured(1)));
            akhir = m.capturedEnd();
        }
        if (waktuList.isEmpty()) continue;

        QString teks = baris.mid(akhir).trimmed();
        if (teks.isEmpty()) continue;

        for (qint64 w : waktuList)
            hasil.push_back({w + meta.offset_ms, teks});
    }

    std::sort(hasil.begin(), hasil.end(), [](const BariLirik& a, const BariLirik& b) {
        return a.waktu_ms < b.waktu_ms;
    });

    if (info) *info = meta;
    return hasil;
}

QVector<BariLirik> bacaLRC(const QString& path, InfoLagu* info) {
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) return {};
    QTextStream in(&f);
    in.setEncoding(QStringConverter::Utf8);
    QString isi = in.readAll();
    f.close();
    return parseStringLRC(isi, info);
}

QVector<BariLirik> bacaSRT(const QString& path) {
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) return {};
    QTextStream in(&f);
    in.setEncoding(QStringConverter::Utf8);

    QVector<BariLirik> hasil;
    QRegularExpression rw(R"((\d{2}:\d{2}:\d{2},\d{3})\s*-->)");
    QString kumpul; qint64 ts = -1;

    while (!in.atEnd()) {
        QString baris = in.readLine().trimmed();
        if (baris.isEmpty()) {
            if (ts >= 0 && !kumpul.isEmpty())
                hasil.push_back({ts, kumpul.trimmed()});
            kumpul.clear(); ts = -1;
            continue;
        }
        bool angka; baris.toInt(&angka);
        if (angka) continue;
        auto m = rw.match(baris);
        if (m.hasMatch()) { ts = srtKeMs(m.captured(1)); continue; }
        if (ts >= 0) { if (!kumpul.isEmpty()) kumpul += " "; kumpul += baris; }
    }
    if (ts >= 0 && !kumpul.isEmpty()) hasil.push_back({ts, kumpul.trimmed()});

    f.close();
    return hasil;
}

QVector<BariLirik> bacaTXT(const QString& path) {
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) return {};
    QTextStream in(&f);
    in.setEncoding(QStringConverter::Utf8);

    QVector<BariLirik> hasil;
    qint64 t = 0;
    while (!in.atEnd()) {
        QString b = in.readLine().trimmed();
        if (b.isEmpty()) { t += 1500; continue; }
        hasil.push_back({t, b});
        t += 3000;
    }
    f.close();
    return hasil;
}

qint64 lrcKeMs(const QString& t) {
    QRegularExpression r(R"((\d+):(\d+)[.:](\d+))");
    auto m = r.match(t);
    if (!m.hasMatch()) return 0;
    int fr = m.captured(3).toInt();
    int ms = m.captured(3).length() <= 2 ? fr * 10 : fr;
    return (qint64)m.captured(1).toInt() * 60000 + m.captured(2).toInt() * 1000 + ms;
}

qint64 srtKeMs(const QString& t) {
    QRegularExpression r(R"((\d+):(\d+):(\d+),(\d+))");
    auto m = r.match(t);
    if (!m.hasMatch()) return 0;
    return (qint64)m.captured(1).toInt() * 3600000 + m.captured(2).toInt() * 60000
         + m.captured(3).toInt() * 1000 + m.captured(4).toInt();
}


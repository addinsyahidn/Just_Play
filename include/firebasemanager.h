#ifndef FIREBASEMANAGER_H
#define FIREBASEMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QtQml/QQmlEngine>

class FirebaseManager : public QObject
{
    Q_OBJECT
public:
    explicit FirebaseManager(QObject *parent = nullptr);

    Q_INVOKABLE void getSongList();
    Q_INVOKABLE void sendTestScore(QString user, int score);

signals:
    void songsLoaded(QJsonArray songs);
    void signInSuccess(QString idToken, QString localId);
    void signInFailed(QString errorMessage);

private:
    QNetworkAccessManager *networkManager;
    QString dbUrl = "https://firebasedatabase.app";
};

#endif // FIREBASEMANAGER_H

#include "firebasemanager.h"
#include <QDateTime>
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QSettings>

FirebaseManager::FirebaseManager(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);
}

void FirebaseManager::getSongList() {
    QUrl url(dbUrl + "songs.json");
    QNetworkReply *reply = networkManager->get(QNetworkRequest(url));
    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray response = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(response);
            if (doc.isArray()) emit songsLoaded(doc.array());
            else if (doc.isObject()) {
                QJsonArray arr; arr.append(doc.object()); emit songsLoaded(arr);
            }
        }
        reply->deleteLater();
    });
}

void FirebaseManager::sendTestScore(QString user, int score) {
    QUrl url(dbUrl + "scores.json");
    QJsonObject json;
    json["username"] = user;
    json["score"] = score;
    json["timestamp"] = QDateTime::currentDateTime().toString();
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply *reply = networkManager->post(request, QJsonDocument(json).toJson());
    connect(reply, &QNetworkReply::finished, [reply]() { reply->deleteLater(); });
}

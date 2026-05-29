#include "authmanager.h"
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonObject>

AuthManager::AuthManager(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);
}

void AuthManager::signInUser(QString email, QString password, bool rememberMe) {
    QString apiKey = "AIzaSyCac3Q1ZEY9fJB5NpHHCzsc7jrC2AdWO4A";

    QUrl url("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword");
    QUrlQuery query;
    query.addQueryItem("key", apiKey);
    url.setQuery(query);

    QJsonObject jsonPayload;
    jsonPayload["email"] = email;
    jsonPayload["password"] = password;
    jsonPayload["returnSecureToken"] = true;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(jsonPayload).toJson());

    connect(reply, &QNetworkReply::finished, [this, reply, email, password, rememberMe]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonObject jsonObj = QJsonDocument::fromJson(responseData).object();

            QString idToken = jsonObj["idToken"].toString();
            QString localId = jsonObj["localId"].toString();
            QString refreshToken = jsonObj["refreshToken"].toString();

            if (rememberMe) {
                QSettings settings("AplikasiKaraoke", "FirebaseConfig");
                settings.setValue("auth/refresh_token", refreshToken);
            } else {
                QSettings settings("AplikasiKaraoke", "FirebaseConfig");
                settings.remove("auth/refresh_token");
            }

            qDebug() << "Sign-in sukses! ID Pengguna:" << localId;
            emit signInSuccess(idToken, localId);
        }
        else {
            QByteArray errorData = reply->readAll();
            QJsonObject errorObj = QJsonDocument::fromJson(errorData).object();
            QString errorMessage = errorObj["error"].toObject()["message"].toString();

            if (errorMessage == "EMAIL_NOT_FOUND") {
                qDebug() << "Email belum terdaftar. Mengalihkan otomatis ke Sign-Up...";
                this->signUpUser(email, password, rememberMe);
            }
            else {
                if(errorMessage.isEmpty()) errorMessage = reply->errorString();
                qDebug() << "Gagal masuk:" << errorMessage;
                emit signInFailed(errorMessage);
            }
        }
        reply->deleteLater();
    });
}

void AuthManager::signUpUser(QString email, QString password, bool rememberMe) {
    QString apiKey = "AIzaSyCac3Q1ZEY9fJB5NpHHCzsc7jrC2AdWO4A";

    QUrl url("https://identitytoolkit.googleapis.com/v1/accounts:signUp");
    QUrlQuery query;
    query.addQueryItem("key", apiKey);
    url.setQuery(query);

    QJsonObject jsonPayload;
    jsonPayload["email"] = email;
    jsonPayload["password"] = password;
    jsonPayload["returnSecureToken"] = true;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(jsonPayload).toJson());

    connect(reply, &QNetworkReply::finished, [this, reply, rememberMe]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonObject jsonObj = QJsonDocument::fromJson(responseData).object();

            QString idToken = jsonObj["idToken"].toString();
            QString localId = jsonObj["localId"].toString();
            QString refreshToken = jsonObj["refreshToken"].toString();

            if (rememberMe) {
                QSettings settings("AplikasiKaraoke", "FirebaseConfig");
                settings.setValue("auth/refresh_token", refreshToken);
            }

            qDebug() << "Akun baru otomatis tercipta dengan ID:" << localId;
            emit signInSuccess(idToken, localId);
        } else {
            QByteArray errorData = reply->readAll();
            QJsonObject errorObj = QJsonDocument::fromJson(errorData).object();
            QString errorMessage = errorObj["error"].toObject()["message"].toString();

            if(errorMessage.isEmpty()) errorMessage = reply->errorString();
            emit signInFailed(errorMessage);
        }
        reply->deleteLater();
    });
}

void AuthManager::checkAutoLogin() {
    isLoggingOut = false;

    QSettings settings("AplikasiKaraoke", "FirebaseConfig");
    QString savedRefreshToken = settings.value("auth/refresh_token", "").toString();

    if (savedRefreshToken.isEmpty()) {
        emit signInFailed("NO_SAVED_SESSION");
        return;
    }

    qDebug() << "Mencoba menukar refresh token untuk auto-login...";
    QString apiKey = "AIzaSyCac3Q1ZEY9fJB5NpHHCzsc7jrC2AdWO4A";
    QUrl url("https://securetoken.googleapis.com/v1/token");
    QUrlQuery query;
    query.addQueryItem("key", apiKey);
    url.setQuery(query);

    QJsonObject jsonPayload;
    jsonPayload["grant_type"] = "refresh_token";
    jsonPayload["refresh_token"] = savedRefreshToken;

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(jsonPayload).toJson());

    connect(reply, &QNetworkReply::finished, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonObject jsonObj = QJsonDocument::fromJson(responseData).object();

            QString newIdToken = jsonObj["id_token"].toString();
            QString localId = jsonObj["user_id"].toString();
            QString newRefreshToken = jsonObj["refresh_token"].toString();

            if (!isLoggingOut) {
                QSettings settingsInside("AplikasiKaraoke", "FirebaseConfig");
                settingsInside.setValue("auth/refresh_token", newRefreshToken);
                emit signInSuccess(newIdToken, localId);
            } else {
                qDebug() << "Membatalkan penyimpanan token otomatis karena pengguna telah logout.";
                emit signInFailed("LOGOUT_DURING_CHECK");
            }

            QSettings settingsInside("AplikasiKaraoke", "FirebaseConfig");
            settingsInside.setValue("auth/refresh_token", newRefreshToken);

            emit signInSuccess(newIdToken, localId);
        } else {
            QSettings settingsInside("AplikasiKaraoke", "FirebaseConfig");
            settingsInside.remove("auth/refresh_token");
            emit signInFailed("SESSION_EXPIRED");
        }
        reply->deleteLater();
    });
}

void AuthManager::logoutUser() {
    isLoggingOut = true;
    QSettings settings("AplikasiKaraoke", "FirebaseConfig");
    settings.remove("auth/refresh_token");
    qDebug() << "Sesi berhasil dihapus secara permanen.";
}

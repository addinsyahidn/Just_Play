#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSettings>
#include <QtQml/QQmlEngine>

class AuthManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT // Agar kelas ini bisa langsung dipanggil di QML tanpa registrasi manual

public:
    explicit AuthManager(QObject *parent = nullptr);

    // Fungsi yang akan dipanggil dari sisi UI QML
    Q_INVOKABLE void signInUser(QString email, QString password, bool rememberMe);
    Q_INVOKABLE void signUpUser(QString email, QString password, bool rememberMe);
    Q_INVOKABLE void checkAutoLogin();
    Q_INVOKABLE void logoutUser();

signals:
    // Sinyal untuk memberi tahu UI QML hasil dari proses autentikasi
    void signInSuccess(QString idToken, QString localId);
    void signInFailed(QString errorMessage);

private:
    QNetworkAccessManager *networkManager;
    bool isLoggingOut = false;
};

#endif // AUTHMANAGER_H

#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QString>
#include <QHash>
#include <QCryptographicHash>

class AuthManager : public QObject {
    Q_OBJECT
public:
    explicit AuthManager(QObject *parent = nullptr);
    Q_INVOKABLE bool registerUser(const QString &username, const QString &password);
    Q_INVOKABLE bool loginUser(const QString &username, const QString &password);
    Q_INVOKABLE bool isLoggedIn() const;
    Q_INVOKABLE QString getCurrentUsername() const;
    Q_INVOKABLE void logout();

signals:
    void loginSuccess();
    void loginFailed(const QString &message);
    void registerSuccess();
    void registerFailed(const QString &message);

private:
    struct UserData {
        QString username;
        QString passwordHash;
    };
    QHash<QString, UserData> m_users;
    QString m_currentUser;
    bool m_isLoggedIn = false;
    QString hashPassword(const QString &password);
};

#endif

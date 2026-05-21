#include "authmanager.h"

AuthManager::AuthManager(QObject *parent) : QObject(parent) {
    registerUser("admin", "12345"); // Akun tes
}

bool AuthManager::registerUser(const QString &username, const QString &password) {
    if (username.isEmpty() || password.isEmpty()) {
        emit registerFailed("Username/Password kosong!");
        return false;
    }
    if (m_users.contains(username)) {
        emit registerFailed("Username sudah ada!");
        return false;
    }
    UserData newUser;
    newUser.username = username;
    newUser.passwordHash = hashPassword(password);
    m_users.insert(username, newUser);
    emit registerSuccess();
    return true;
}

bool AuthManager::loginUser(const QString &username, const QString &password) {
    if (!m_users.contains(username)) {
        emit loginFailed("Username tidak ditemukan!");
        return false;
    }
    if (m_users[username].passwordHash != hashPassword(password)) {
        emit loginFailed("Password salah!");
        return false;
    }
    m_currentUser = username;
    m_isLoggedIn = true;
    emit loginSuccess();
    return true;
}

bool AuthManager::isLoggedIn() const { return m_isLoggedIn; }
QString AuthManager::getCurrentUsername() const { return m_currentUser; }
void AuthManager::logout() { m_currentUser = ""; m_isLoggedIn = false; }

QString AuthManager::hashPassword(const QString &password) {
    QByteArray hash = QCryptographicHash::hash(password.toUtf8(), QCryptographicHash::Sha256);
    return QString(hash.toHex());
}
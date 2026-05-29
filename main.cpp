#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "firebasemanager.h"
#include "authmanager.h"
#include "datamanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    FirebaseManager firebaseManager;
    AuthManager authManager;
    DataManager dataManager;

    QObject::connect(&authManager, &AuthManager::signInSuccess,
                     &dataManager, [&dataManager](const QString &idToken, const QString &localId) {
                         qDebug() << "Sinyal sukses ditangkap di main.cpp! Memulai pembuatan koleksi Firestore...";
                         dataManager.initializeUserCollections(localId, idToken);
                     });

    engine.rootContext()->setContextProperty("firebaseManager", &firebaseManager);
    engine.rootContext()->setContextProperty("authManager", &authManager);
    engine.rootContext()->setContextProperty("DataManager", &dataManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("appKaraokeApp", "Main");

    return QCoreApplication::exec();
}

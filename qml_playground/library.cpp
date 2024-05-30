#include "library.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

using namespace Qt::StringLiterals;

int run() {
    int argc = 0;
    char *argv[] = {};
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qml/main.qml"_s);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app,
                     [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

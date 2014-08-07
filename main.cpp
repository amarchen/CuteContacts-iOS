#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickView>
#include <QDebug>
#include "objectiveutils.h"

int main(int argc, char *argv[])
{
    ObjectiveUtils::setGoodStatusBarStyle();
    QApplication app(argc, argv);
    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:///main.qml")));
    view.showFullScreen();

    return app.exec();
}

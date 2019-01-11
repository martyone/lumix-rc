# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-lumix-rc

CONFIG += sailfishapp

SOURCES += src/harbour-lumix-rc.cpp

DISTFILES += qml/harbour-lumix-rc.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-lumix-rc.changes.in \
    rpm/harbour-lumix-rc.changes.run.in \
    rpm/harbour-lumix-rc.spec \
    rpm/harbour-lumix-rc.yaml \
    translations/*.ts \
    harbour-lumix-rc.desktop \
    qml/pages/MainPage.qml \
    qml/pages/SettingsPage.qml \
    qml/Controller.qml \
    qml/qmldir

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-lumix-rc-cs.ts

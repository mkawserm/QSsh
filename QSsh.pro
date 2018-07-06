#-------------------------------------------------
#
# Project created by QtCreator 2018-04-10T04:25:55
#
#-------------------------------------------------

TARGET = QSsh
TEMPLATE = lib
CONFIG += c++11
QT += gui
QT += core

!win32:VERSION = 1.0.0

include(ssh/ssh.pri)



#CONFIG(debug, debug|release) {
#     mac: TARGET = $$join(TARGET,,,_debug)
#     win32: TARGET = $$join(TARGET,,,d)
#}

TEMPNAME = $${QMAKE_QMAKE}
QTPATH = $$dirname(TEMPNAME)

#OBJECTS_DIR=.obj
#MOC_DIR=.moc

QSSH_HEADERS = $$QSSH_PUBLIC_HEADERS $$BOTAN_PUBLIC_HEADERS
DEFINES+=QSSH_LIBRARY
DEFINES+=BOTAN_LIBRARY
msvc*: DEFINES += _CRT_SECURE_NO_WARNINGS


unix{
    CONFIG += lib_bundle
    QMAKE_PKGCONFIG_DESTDIR = pkgconfig
    FRAMEWORK_HEADERS.version = Versions
    FRAMEWORK_HEADERS.files = $$QSSH_HEADERS
    FRAMEWORK_HEADERS.path = Headers
    QMAKE_BUNDLE_DATA += FRAMEWORK_HEADERS
    target.path=$$QTPATH/../lib/$${LIB_ARCH}
    INSTALLS = target
}

android{
    CONFIG -= android_install
    headers.path=$$[QT_INSTALL_HEADERS]/QSsh
    headers.files=$$QSSH_HEADERS
    target.path=$$[QT_HOST_LIBS]
    INSTALLS = headers target
}

win32:*g++* {
    headers.path=$$[QT_INSTALL_HEADERS]/QSsh
    headers.files=$$QSSH_HEADERS

    copy_dll.files = $$[QT_HOST_LIBS]/QSsh.dll
    copy_dll.path = $$QTPATH

    target.path=$$[QT_HOST_LIBS]

    INSTALLS = headers target copy_dll
}

linux:!android{
    headers.path=$$[QT_INSTALL_HEADERS]/QSsh
    headers.files=$$QSSH_HEADERS
    target.path=$$[QT_INSTALL_HEADERS]/../lib
    INSTALLS = headers target
}
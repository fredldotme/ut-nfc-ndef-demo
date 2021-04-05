QT += nfc widgets
requires(qtConfig(filedialog))

TARGET = ndefeditor
TEMPLATE = app

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    textrecordeditor.cpp \
    urirecordeditor.cpp \
    mimeimagerecordeditor.cpp

HEADERS += \
    mainwindow.h \
    textrecordeditor.h \
    urirecordeditor.h \
    mimeimagerecordeditor.h

FORMS += \
    mainwindow.ui \
    textrecordeditor.ui \
    urirecordeditor.ui \
    mimeimagerecordeditor.ui

target.path = /
INSTALLS += target

# figure out the current build architecture
CLICK_ARCH=$$system(dpkg-architecture -qDEB_HOST_ARCH)

# do not remove this line, it is required by the IDE even if you do
# not substitute variables in the manifest file
UBUNTU_MANIFEST_FILE = $$PWD/manifest.json.in


# substitute the architecture in the manifest file
manifest_file.output   = manifest.json
manifest_file.CONFIG  += no_link \
                         add_inputs_as_makefile_deps\
                         target_predeps
manifest_file.commands = sed s/@CLICK_ARCH@/$$CLICK_ARCH/g ${QMAKE_FILE_NAME} > ${QMAKE_FILE_OUT}
manifest_file.input = UBUNTU_MANIFEST_FILE
QMAKE_EXTRA_COMPILERS += manifest_file

# installation path of the manifest file
mfile.CONFIG += no_check_exist
mfile.files  += $$OUT_PWD/manifest.json
mfile.path = /

# AppArmor profile
apparmor.files += $$PWD/ndefeditor.apparmor
apparmor.path = /

# Desktop launcher icon
desktopicon.files += $$PWD/logo.svg
desktopicon.path = /

# Desktop launcher
desktop.files += $$PWD/ndefeditor.desktop
desktop.path = /

INSTALLS += mfile apparmor desktopicon desktop

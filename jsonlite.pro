TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

## R includes (call devtools::use_qtcreator() to update)
INCLUDEPATH += /Library/Frameworks/R.framework/Resources/include
INCLUDEPATH += $$PWD/inst/include

HEADERS += src/*.h
HEADERS += src/*.hpp

SOURCES += src/*.c
SOURCES += src/*.cpp

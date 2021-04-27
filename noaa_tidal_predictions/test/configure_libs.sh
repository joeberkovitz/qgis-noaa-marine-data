#!/bin/sh
#
# Create lib/ subdirectory for selective linking of ImageIO image libraries and standard libsqlite3
mkdir -p lib
ln -sf /System/Library/Frameworks/ImageIO.framework/Resources/*.dylib lib/
ln -sf /usr/lib/libsqlite3*.dylib lib/

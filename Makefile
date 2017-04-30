all: build

test:
	swift test

build:
	swift build

rebuild: clean build

clean:
	swift package clean

distclean:
	swift package clean dist

tags:
	ctags -R ./ ../swift-corelibs-foundation/

.PHONY: all build rebuild clean distclean pull-master tags

all: build

test:
	swift test

build:
	swift build

rebuild: clean build

clean:
	swift build --clean

distclean:
	swift build --clean dist

tags:
	ctags -R ./ ../swift-corelibs-foundation/

.PHONY: all build rebuild clean distclean pull-master tags

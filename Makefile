
include ./buildconf.mk

all:
	$(MAKE) -C libfskit REPL=$(REPL)
	$(MAKE) -C fuse

install:
	$(MAKE) -C libfskit install
	$(MAKE) -C fuse install

test:
	$(MAKE) -C test REPL=$(REPL)

fuse-demo:
	$(MAKE) -C demo 

uninstall:
	$(MAKE) -C libfskit uninstall
	$(MAKE) -C fuse uninstall

clean:
	$(MAKE) -C libfskit clean
	$(MAKE) -C test clean
	$(MAKE) -C fuse clean
	$(MAKE) -C demo clean

.PHONY: all install clean

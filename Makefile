CPP    := g++ -Wall -g -fPIC
LIB   := -lpthread -lrt
INC   := -I.
C_SRCS:= $(wildcard *.c)
CXSRCS:= $(wildcard *.cpp)
HEADERS := $(wildcard *.h)
OBJ   := $(patsubst %.c,%.o,$(C_SRCS)) $(patsubst %.cpp,%.o,$(CXSRCS))
DEFS  := -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS

LIBFSKIT := libfskit.so
LIBFSKIT_SO := libfskit.so.1
LIBFSKIT_LIB := libfskit.so.1.0.1

PREFIX		?= /usr
LIBDIR		?= $(PREFIX)/lib
INCLUDEDIR	?= $(PREFIX)/include/fskit

all: fskit

fskit: $(OBJ)
	$(CPP) -shared -Wl,-soname,$(LIBFSKIT_SO) -o $(LIBFSKIT_LIB) $(OBJ) $(LIBINC) $(LIB)
	$(SHELL) -c "if ! test -L $(LIBFSKIT_SO); then /bin/ln -s $(LIBFSKIT_LIB) $(LIBFSKIT_SO); fi"
	$(SHELL) -c "if ! test -L $(LIBFSKIT); then /bin/ln -s $(LIBFSKIT_SO) $(LIBFSKIT); fi"

install: fskit
	mkdir -p $(DESTDIR)/$(LIBDIR) $(DESTDIR)/$(INCLUDEDIR)
	cp -a $(LIBFSKIT) $(LIBFSKIT_SO) $(LIBFSKIT_LIB) $(DESTDIR)/$(LIBDIR)
	cp -a $(HEADERS) $(DESTDIR)/$(INCLUDEDIR)

%.o : %.c
	$(CPP) -o $@ $(INC) -c $< $(DEFS)

%.o : %.cpp
	$(CPP) -o $@ $(INC) -c $< $(DEFS)

.PHONY: clean
clean:
	/bin/rm -f $(OBJ) $(LIBFSKIT_LIB) $(LIBFSKIT_SO) $(LIBFSKIT)

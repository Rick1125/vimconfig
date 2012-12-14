.PHONY: init

all:
	(cd bundle/vimproc;make -f make_unix.mak)
	git pull origin master
	git submodule foreach git pull origin master

init:
	git submodule init
	git submodule update


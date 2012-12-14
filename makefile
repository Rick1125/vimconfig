.PHONY: init

all:
	git pull origin master
	git submodule foreach git pull origin master

init:
	git submodule init
	git submodule update


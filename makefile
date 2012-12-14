vimproc=bundle/vimproc/autoload/vimproc_unix.so

.PHONY: init link config
all: $(vimproc)
	git pull origin master
	git submodule update
#	git submodule foreach git pull origin master

init: link config
	git submodule init
	git submodule update

$(vimproc):
	(cd bundle/vimproc;make -f make_unix.mak)

config:
	git config user.name "Rick1125"
	git remote set-url origin git@github.com:Rick1125/vimconfig.git

link:
	rm ~/.vim && ln -sf `pwd` ~/.vim
	ln -sf `pwd`/.vimrc ~

vimproc=bundle/vimproc/autoload/vimproc_unix.so

.PHONY: init
all: $(vimproc)
	git pull origin master
	git submodule update
#	git submodule foreach git pull origin master
#	test ~/.vimrc; ln -sf `pwd` ~/.vim
#	test ~/.vim; ln -sf `pwd`/.vimrc ~

init:
	git config user.name "Rick1125"
	git remote set-url origin git@github.com:Rick1125/vimconfig.git
	git submodule init
	git submodule update

$(vimproc):
	(cd bundle/vimproc;make -f make_unix.mak)

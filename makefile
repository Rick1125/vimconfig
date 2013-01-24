username="Rick1125"
git_repository=git@github.com:Rick1125/vimconfig.git
vimproc=bundle/vimproc/autoload/vimproc_unix.so

.PHONY: init link config
all: $(vimproc)
	git pull origin master
	git submodule update --init
	git submodule update --recursive
#git submodule foreach git pull origin master

init: link config
	git submodule update --init

$(vimproc):
	(cd bundle/vimproc;make -f make_unix.mak)

config:
	git config user.name ${username}
	git remote set-url origin ${git_repository}

link:
	rm -fr ~/.vim && ln -sf `pwd` ~/.vim
	ln -sf `pwd`/.vimrc ~

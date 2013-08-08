OS := $(shell uname)
type=unix
username="Rick1125"
git_repository=git@github.com:Rick1125/vimconfig.git
vimproc=bundle/vimproc/autoload/vimproc_$(type).so

.PHONY: update install config
all: $(vimproc)
	git pull origin master
	git submodule foreach git pull origin master

$(vimproc): 
ifeq ($(OS), Darwin)
type=mac
endif
	(cd bundle/vimproc;make -f make_$(type).mak)

update:
#	git submodule update --recursive
	@git submodule update --init

config:
	@git config http.sslVerify false
	@git config user.name ${username}
	@git remote set-url origin ${git_repository}

install: config
	rm -fr ~/.vim && ln -sf `pwd` ~/.vim
	ln -sf `pwd`/.vimrc ~

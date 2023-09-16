version := $(shell git --version | awk '{print $$3}' | awk -F. '{print ($$1*100+$$2)*100+$$3}')
configs := $(wildcard .gitconfig.v*)
configs := $(foreach config, $(configs), $(shell echo $(config) | awk -F'[.v]' '($$4*100+$$5)*100+$$6<=$(version)'))
configs := .gitconfig.misc $(configs)
ifneq (,$(wildcard /mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe))
	configs := $(configs) .gitconfig.credential.wsl
endif

.PHONY: all clean install uninstall
all: .gitconfig

.gitconfig: $(configs)
	cat $^ > $@

clean:
	rm -f .gitconfig

install: .gitconfig
	cp -a .gitconfig ~/
	cp -a .gitignore ~/

uninstall:
	rm -f ~/.gitconfig
	rm -f ~/.gitignore

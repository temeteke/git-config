version := $(shell git --version | awk '{print $$3}' | awk -F. '{print ($$1*100+$$2)*100+$$3}')
configs := $(wildcard .gitconfig.v*)
configs := $(foreach config, $(configs), $(shell echo $(config) | awk -F'[.v]' '($$4*100+$$5)*100+$$6<=$(version)'))
configs := .gitconfig.misc $(configs)

.PHONY: all clean install uninstall
all: .gitconfig

.gitconfig: $(configs)
	cat $^ > $@

clean:
	rm .gitconfig

install: .gitconfig
	cp .gitconfig ~/
	cp .gitignore ~/

uninstall:
	rm ~/.gitconfig
	rm ~/.gitignore

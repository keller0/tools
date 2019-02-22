install : all

all: sc-install pl-install

sc-install:
	cp -vf sc.sh /usr/local/bin/sc

pl-install:
	cp -vf pipLAN.sh /usr/local/bin/pipLAN
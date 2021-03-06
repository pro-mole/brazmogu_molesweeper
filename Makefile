#A simple Makefile to create our package

EXECNAME=Molesweeper
VERSION=1.0
PACKNAME=$(EXECNAME)-$(VERSION).love

all: $(PACKNAME)

$(PACKNAME): main.lua conf.lua molesweeper screen assets
	zip -9 -q -r $(PACKNAME) conf.lua main.lua molesweeper screen assets
	
run:
	love ./

clean:
	rm -f *.love

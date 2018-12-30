# Makefile for installing 'Losungen for Conky'

# destination directory for installing/uninstalling the program
DEST	=	/usr/local/bin

# run the following targets unconditionally
.PHONY: help install uninstall

# install the program onto computer
# This is also the default make target, which works by calling 
# make without parameters.
install:
	@echo "Installing..."
	cp losung.pl $(DEST)	
	cp losungen????.csv $(DEST)
	chmod +rx $(DEST)/losung.pl
	chmod +r $(DEST)/losungen????.csv
	@echo "result:"
	@ls -l $(DEST)/losung*

# remove program from computer
uninstall:
	@echo "Uninstalling..."
	rm $(DEST)/losung.pl
	rm $(DEST)/losungen????.csv

# show a short help
help:
	@echo "Losungen for Conky - shows daily Bible verses."
	@echo
	@echo "Install the program by typing 'make install' as user root."
	@echo "By default, this will install the program to /usr/local/bin."
	@echo "You can choose another program directory by typing 'make DEST=<program directory> install' (without arrow brackets)."
	@echo "To uninstall the program, type 'make uninstall' or 'make DEST=<program directory> uninstall' (without arrow brackets)."
	@echo "For further information read file README.md (in English) or LIESMICH.md (in German)"

dist:
	@cp --verbose losung.pl $(tempdir); \
	cp --verbose Makefile $(tempdir); \
	cp --verbose conkyrc-*-example $(tempdir)

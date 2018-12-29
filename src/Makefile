# Makefile for installing 'Losungen for Conky'

# destination directory for installing/uninstalling the program
DEST	=	/usr/local/bin

# install the program onto computer
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
	@echo "For further information read file readme.txt (in English) or liesmich.txt (in German)"
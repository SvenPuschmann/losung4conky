# Makefile for development
# TODO: Properly split the file into sub-makefiles in each directory.

# Set variables
PACKAGE-DIR	=	package
DIST-NAME	= 	losung4conky
DEPLOY-DIR	=	$(PACKAGE-DIR)/$(DIST-NAME)

# By default (i.e. running make without parameters) create distribution packages.
# The default target must be the first target.
# In GNU make later that version 3.80 we can also use the .DEFAULT_GOAL variable.
default: dist zip

# run the following targets unconditionally
.PHONY: all clean deploy distclean prep tar zip

# reuse targets install, uninstall, help from subdirectory src
# include src/Makefile

all:
	@cd data && $(MAKE) all

# copy files to the deployment directory and create archive
dist-tar: clean prep tar
dist-zip: clean prep zip
dist: dist-tar

clean:
	@cd data && $(MAKE) clean

distclean: clean
	@cd package && $(MAKE) distclean

# copy files to the deployment directory
prep:
	@echo "*** Copying files to the deployment directory ***"
	mkdir -p $(DEPLOY-DIR) && \
	cp src/losung.pl $(DEPLOY-DIR) && \
	cp src/Makefile $(DEPLOY-DIR) && \
	cp src/conkyrc-*-example $(DEPLOY-DIR) && \
	cp doc/LIESMICH.md $(DEPLOY-DIR) && \
	cp doc/README.md $(DEPLOY-DIR) && \
	cp doc/COPYING $(DEPLOY-DIR) && \
	cp data/losungen*.csv $(DEPLOY-DIR)
	@echo "Done"

# create distribution packages
tar:
	@echo "*** Creating TAR distribution packages ***"
	cd $(PACKAGE-DIR) && \
	tar -cf $(DIST-NAME).tar $(DIST-NAME) && \
	gzip -k $(DIST-NAME).tar
	@echo "Done"

zip:
	@echo "*** Creating ZIP distribution package ***"
	cd $(PACKAGE-DIR) && \
	zip -r -b /tmp $(DIST-NAME) $(DIST-NAME)
	@echo "Done"


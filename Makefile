# Makefile for development
# TODO: Properly split the file into sub-makefiles in each directory.

# Set variables
DIST-DIR	=	dist
DIST-NAME	= 	losung4conky
DIST-HELPER-DIR	=	$(DIST-DIR)/$(DIST-NAME)

# run the following targets unconditionally
.PHONY: all clean deploy distclean prep tar zip

# By default (i.e. running make without parameters) create distribution packages.
# The default target must be the first target.
# In GNU make later that version 3.80 we can also use the .DEFAULT_GOAL variable.
all:
	@cd data && $(MAKE) all

# reuse targets install, uninstall, help from subdirectory src
# include src/Makefile



# copy files to the deployment directory and create archive
dist-tar: clean prep tar
dist-zip: clean prep zip
dist: dist-tar

clean:
	@cd data && $(MAKE) clean

distclean: clean
	@cd dist && $(MAKE) distclean

# copy files to the deployment directory
prep:
	@echo "*** Copying files to the deployment directory ***"
	mkdir -p $(DIST-HELPER-DIR) && \
	cp src/losung.pl $(DIST-HELPER-DIR) && \
	cp src/Makefile $(DIST-HELPER-DIR) && \
	cp src/conkyrc-*-example $(DIST-HELPER-DIR) && \
	cp doc/LIESMICH.md $(DIST-HELPER-DIR) && \
	cp doc/README.md $(DIST-HELPER-DIR) && \
	cp doc/COPYING $(DIST-HELPER-DIR) && \
	cp data/losungen*.csv $(DIST-HELPER-DIR)
	@echo "Done"

# create distribution packages
tar:
	@echo "*** Creating TAR distribution packages ***"
	cd $(DIST-DIR) && \
	tar -cf $(DIST-NAME).tar $(DIST-NAME) && \
	gzip -k $(DIST-NAME).tar
	@echo "Done"

zip:
	@echo "*** Creating ZIP distribution package ***"
	cd $(DIST-DIR) && \
	zip -r -b /tmp $(DIST-NAME) $(DIST-NAME)
	@echo "Done"


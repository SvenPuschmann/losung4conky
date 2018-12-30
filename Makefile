# Makefile for development
# TODO: Properly split the file into sub-makefiles in each directory.

# Set variables
DIST-DIR	=	dist
DIST-NAME	= 	losung4conky
DIST-HELPER-DIR	=	$(DIST-DIR)/$(DIST-NAME)

# run the following targets unconditionally
.PHONY: all clean dist distclean tar zip

# By default (i.e. running make without parameters) create distribution packages.
# The default target must be the first target.
# In GNU make later that version 3.80 we can also use the .DEFAULT_GOAL variable.
all:
	@cd data && $(MAKE) all

# reuse targets install, uninstall, help from subdirectory src
# include src/Makefile
dist:
	export tempdir=$$( mktemp -d -t ); \
	export distname=$(DIST-NAME); \
	for subdir in src data doc dist; do \
		cd $$subdir && $(MAKE) dist && cd -; \
	done; \
	rm -rf $$tempdir

# copy files to the deployment directory and create archive
dist-zip: prep zip

clean:
	@cd data && $(MAKE) clean

distclean: clean
	@cd dist && $(MAKE) distclean

# create distribution packages
zip:
	@echo "*** Creating ZIP distribution package ***"
	cd $(DIST-DIR) && \
	zip -r -b /tmp $(DIST-NAME) $(DIST-NAME)
	@echo "Done"


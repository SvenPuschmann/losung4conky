# makefile for development
PACKAGE-DIR	=	package
ZIP-FILE	= 	losung4conky
DEPLOY-DIR	=	$(PACKAGE-DIR)/$(ZIP-FILE)

include src/Makefile

# run the following targets unconditionally
.PHONY: clean deploy prep zip

# copy files to the deployment directory and create archive
deploy: clean prep zip

# clean output directory: remove everything but .gitignore
clean:
	@echo "*** Cleaning output directory ***"
	cd $(PACKAGE-DIR) && \
	find . ! -name '.gitignore' ! -name '.' -exec rm -rf {} +
	@echo "Done"

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
zip:
	@echo "*** Creating distribution package ***"
	cd $(PACKAGE-DIR) && zip -r -b /tmp $(ZIP-FILE) $(ZIP-FILE)
	@echo "Done"


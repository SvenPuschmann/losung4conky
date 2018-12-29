# makefile for development
PACKAGE-DIR	=	package
ZIP-FILE	= 	losung4conky
DEPLOY-DIR	=	$(PACKAGE-DIR)/$(ZIP-FILE)

include src/Makefile

# copy files to the deployment directory and create archive
deploy: prep zip

# clean output directory
clean:
	@echo "*** Cleaning output directory ***"
	rm -rf $(PACKAGE-DIR)
	mkdir -p $(DEPLOY-DIR)
	@echo "Done"

# copy files to the deployment directory 
prep: clean
	@echo "*** Copying files to the deployment directory ***"
	cp src/losung.pl $(DEPLOY-DIR)
	cp src/Makefile $(DEPLOY-DIR)
	cp src/conkyrc-*-example $(DEPLOY-DIR)
	cp doc/LIESMICH.md $(DEPLOY-DIR)
	cp doc/README.md $(DEPLOY-DIR)
	cp doc/COPYING $(DEPLOY-DIR)
	cp data/losungen*.csv $(DEPLOY-DIR)
	@echo "Done"

# create distribution packages
zip:
	@echo "*** Creating distribution packages ***"
	cd $(PACKAGE-DIR)&& zip -r -b /tmp $(ZIP-FILE) $(ZIP-FILE)
	@echo "Done"
	

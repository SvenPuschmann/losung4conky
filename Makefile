# Makefile für die Entwicklung
PACKAGE-DIR	=	package
ZIP-FILE	= 	losung4conky
DEPLOY-DIR	=	$(PACKAGE-DIR)/$(ZIP-FILE)

include src/Makefile

# Dateien in das Auslieferungsverzeichnis kopieren und verpacken
deploy: prep zip

# Ausgabeverzeichnis leeren
clean:
	@echo "*** Ausgabeverzeichnis leeren ***"
	rm -rf $(PACKAGE-DIR)
	mkdir -p $(DEPLOY-DIR)
	@echo

# Dateien in das Auslieferungsverzeichnis kopieren
prep: clean
	@echo "*** Dateien in das Auslieferungsverzeichnis kopieren ***"
	cp src/losung.pl $(DEPLOY-DIR)
	cp src/Makefile $(DEPLOY-DIR)
	cp src/conkyrc-*-example $(DEPLOY-DIR)
	cp doc/LIESMICH.txt $(DEPLOY-DIR)
	cp doc/README.txt $(DEPLOY-DIR)
	cp doc/COPYING $(DEPLOY-DIR)
	cp data/losungen*.csv $(DEPLOY-DIR)
	@echo

# Dateien verpacken
zip:
	@echo "*** Dateien verpacken ***"
	cd $(PACKAGE-DIR)&& zip -r -b /tmp $(ZIP-FILE) $(ZIP-FILE)
	@echo
	

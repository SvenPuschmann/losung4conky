.PHONY: dist distclean

dist:
	@echo Creating TAR distribution packages $(distname); \
	basedir=`basename $(tempdir)`; \
	cd $(tempdir) && cd .. && \
	rm -rf $(distname) && \
	mv -f $$basedir $(distname) && \
	tar --create --file $(distname).tar --verbose $(distname) && \
	gzip --keep --verbose --force $(distname).tar && \
	mkdir $$basedir &&  \
	mv $(distname).tar* $$basedir && \
	rm -rf $(distname);

dist-zip:
	@echo Creating ZIP distribution package $(distname); \
	basedir=`basename $(tempdir)`; \
	cd $(tempdir) && cd .. && \
	rm -rf $(distname) && \
	mv -f $$basedir $(distname) && \
	zip -r -v -b /tmp $(distname) $(distname) && \
	mkdir $$basedir &&  \
	mv $(distname).zip $$basedir && \
	rm -rf $(distname);

distclean:
	@find . ! -name '.gitignore' ! -name 'Makefile' ! -name '.' -exec \
	rm --force --verbose --recursive {} +

.PHONY: dist distclean

dist:
	@echo Creating TAR distribution packages $(distname); \
	tar --create --file $(distname).tar --verbose $(tempdir) && \
	gzip --keep --verbose --force $(distname).tar

dist-zip:
	@echo Creating ZIP distribution package $(distname); \
	zip -r -v -b /tmp $(distname) $(tempdir)

distclean:
	@find . ! -name '.gitignore' ! -name 'Makefile' ! -name '.' -exec \
	rm --force --verbose --recursive {} +

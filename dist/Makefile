.PHONY: dist distclean

dist:
	@echo Creating TAR distribution package $(distname); \
	tar --create --file $(distname).tar --verbose $(tempdir) && \
	gzip --keep --verbose --force $(distname).tar

distclean:
	@find . ! -name '.gitignore' ! -name 'Makefile' ! -name '.' -exec \
	rm --force --verbose --recursive {} +

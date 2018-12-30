.PHONY: all clean dist

all:
	@datadir=$$( pwd ); \
	tempdir=$$( mktemp -d -t ); \
	currentyear=$$( date +"%Y" ); \
	for year in $$currentyear $$(($$currentyear + 1)); do \
		filename="Losung_"$$year"_CSV.zip"; \
		url="https://www.losungen.de/fileadmin/media-losungen/download/"$$filename; \
		# test whether the watchword ZIP archive exists \
		if curl --output /dev/null --silent --head --fail "$$url"; then \
			echo "Downloading and extracting watchwords "$$year"..."; \
			# download ZIP archive \
			cd $$tempdir; \
			curl --silent $$url -O; \
			# unzip CSV file from ZIP archive \
			unzip -q $$filename *$$year.csv; \
			# rename and move CSV file to the data directory \
			mv *.csv $$datadir/losungen$$year.csv;  \
			# clean temporary directory \
			rm -f *; \
		fi; \
	done; \
	rm -rf $$tempdir

clean:
	@find . ! -name '.gitignore' ! -name 'Makefile' ! -name '.' -exec \
	rm --force --verbose --recursive {} +

dist:
	@cp --verbose losungen*.csv $(tempdir)

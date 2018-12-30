.PHONY: all

all:
	@datadir=$$( pwd ); \
	tempdir=$$( mktemp -d -t ); \
	echo tempdir:$$tempdir;  \
	y=$$( date +"%Y" ); \
	# echo y=$$y; \
	for i in $$y $$(($$y + 1)); do \
		url="https://www.losungen.de/fileadmin/media-losungen/download/Losung_"$$i"_CSV.zip"; \
		# test whether the watchword ZIP archive exists \
		if curl --output /dev/null --silent --head --fail "$$url"; then \
			# download ZIP archive \
			cd $$tempdir; \
			curl $$url -O; \
			# unzip CSV file from ZIP archive \
			unzip -q $$filename *$$year.csv; \
			# rename and move CSV file to the data directory \
			mv *.csv $$datadir/losungen$$year.csv;  \
			# clean temporary directory \
			rm -f *; \
		fi; \
	done; \
	ls -rtl $$tempdir; \
	rm -rf $$tempdir

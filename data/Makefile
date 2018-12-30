.PHONY: all

all:
	y=$$( date +"%Y" ); \
	# echo y=$$y; \
	for i in $$y $$(($$y + 1)); do \
		url="https://www.losungen.de/fileadmin/media-losungen/download/Losung_"$$i"_CSV.zip"; \
		# echo $$url; \
		if curl --output /dev/null --silent --head --fail "$$url"; then \
			echo "URL exists: $$url"; \
		else \
			echo "URL does not exist: $$url"; \
		fi; \
	done \

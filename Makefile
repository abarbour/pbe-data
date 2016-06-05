EMC=2010/2010.094_7.2/B084/fig_timeseries.pdf
EXAMP=example.png

all: $(EXAMP)

$(EXAMP): $(EMC)
	# needs ImageMagick
	convert $< $@

cleandirs:
	find . -type d -empty -delete

EMC=2010/2010.094_7.2/B084/fig_timeseries.pdf
EXAMP=example.png

ALL=$(EXAMP)

all: $(ALL)

$(EXAMP): $(EMC)
	# needs ImageMagick
	convert -density 250 -trim $< -quality 100 $@

clean:
	rm -f $(ALL)

cleandirs:
	find . -type d -empty -delete

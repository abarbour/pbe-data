# pbe-data

This is the full dataset of Plate Boundary Observatory borehole strain timeseries from Barbour and Crowell (2016) "Dynamic Strains for Earthquake Source Characterization".

For each earthquake-station pair the data are in R binary format, with one file ('bsmdata.rda') representing the timeseries of linear gauge strain (in 10<sup>-9</sup>), and another file ('bsmdata_nfo.rda') representing metadata associated with the timeseries. We also include a pdf figure of the timeseries in ('fig_timeseries.pdf') for reference. Here, for example, is the timeseries at B084 for the 2010 Mw 7.2 El Mayor Cucapah earthquake.

![B084-El Mayor](emc.png)

## How to get this data

	git clone git@github.com:abarbour/pbe-data.git

The total size of this repository is on the order of 800 Mb, so the first clone will take a considerable amount of time. This can be minimized by replacing `git clone` with `git clone --depth 1` in the expression above.

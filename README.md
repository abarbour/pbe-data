# pbe-data

This is the full dataset of 
[Plate Boundary Observatory](http://www.unavco.org/projects/major-projects/pbo/pbo.html)
 borehole strain timeseries from Barbour and Crowell (2016) "Dynamic Strains for Earthquake Source Characterization".

For each earthquake-station pair the data are in [R](https://www.r-project.org/)'s
[binary format](https://stat.ethz.ch/R-manual/R-devel/library/base/html/save.html), with one
file (`'bsmdata.rda'`) representing the timeseries of linear gauge strain ( in 10<sup>-9 </sup>), and another 
file (`'bsmdata_nfo.rda'`) representing metadata associated with the timeseries. We also include a
pdf figure of the timeseries in (`'fig_timeseries.pdf'`) for reference. Here, for example, is the timeseries at B084 for the
2010 M<sub>W</sub> 7.2 El Mayor Cucapah earthquake
showing peak strains of nearly 15 &#215; 10<sup>-6</sup> (microstrain).

![B084-El Mayor](example.png)

We have included a sample R script [`plot_bsmdata.R`](plot_bsmdata.R) to show how 
a similar version of this figure can be reproduced.

## How to get this data

Download the full archive here: https://github.com/abarbour/pbe-data/archive/master.zip

Or use version control (git, Subversion, etc.):

	git clone git@github.com:abarbour/pbe-data.git

The total size of this repository is on the order of 800 Mb, so the first 
fetch will take a considerable amount of time. The size can be minimized slightly 
by replacing `git clone` with `git clone --depth 1` in the expression above.

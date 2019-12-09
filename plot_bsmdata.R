#!/usr/bin/env Rscript --no-save

library(stats,graphics,grDevices)

#+++++++++++

# get_oct and plot.hfbsm
source('funcs.R', echo=FALSE)

#+++++++++++

redo <- FALSE
if (!exists("B") | redo){
	load("examp_bsmdata.rda", verbose=TRUE)
}

if (!exists("b") | redo){
	load("examp_bsmdata_nfo.rda", verbose=TRUE)
}

str(B)
class(B)

str(b)
class(b)

get_oct(B)
get_oct(b)

plot(B)
plot(B, win=c(20,300))
plot(B, sc=1e-3, win=200)

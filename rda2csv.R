#!/usr/bin/env Rscript --no-save

# 
# rda2csv:
#
# Script to write the strain timeseries in a given .rda
# file to a more general formal, csv
#

library(stats,graphics,grDevices)
library(readr) # use `install.packages('readr')`

source('funcs.R', echo=FALSE)

rdasrc <- "2010/2010.094_7.2/B084/bsmdata.rda"
csvout <- "eqstrains.csv.gz"
inter <- interactive()

if (!inter){
    cmd <- paste(commandArgs(), collapse=" ")
    args <- commandArgs(trailingOnly = TRUE)
    nargs <- length(args)
    if (!nargs) stop(sprintf("single argument needed, the .rda file path, e.g.: %s", rdasrc), call. = FALSE)
    rdasrc <- args[1]
    if (nargs > 1){
        csvout <- args[2]
    }
} else {
    cmd <- "(interactive)"
}

if (!file.exists(rdasrc)){
    stop(sprintf("file '%s' does not exist.", rdasrc), call. = FALSE)
} else {
    message(sprintf("Converting file '%s' to '%s'", rdasrc, csvout))
}

load(rdasrc, verbose=FALSE)
#Loading objects:
#  B

Dat <- B[['srcdat']]
Datetimes <- B[['Datetime']]
n <- nrow(Dat)
stopifnot(length(Datetimes) == n)

station <- attr(B, 'sta4')
sampling <- attr(B, 'frequency')
eq.origin <- get_oct(B)

# calculate origin time
origin.time <- zapsmall(as.numeric(difftime(Datetimes, eq.origin, units='secs')))

# assemble output data.frame -- to be written to csv
Dat <- as.data.frame(Dat)
FullData <- cbind(data.frame(Station = station, DateTime = format(Datetimes,"%Y/%m/%dT%H:%M:%OS6"), OriginTime = origin.time), Dat)

#print(summary(FullData))

# include header information for later times
header <- sprintf("# command: %s\n# (csv output from %s)\n# station: %s\n# event (OT): %s\n# sampling rate: %s\n# no. points in file: %s\n# N/A values are 'NA'", 
   cmd, rdasrc, station, eq.origin, sampling, n)

readr::write_lines(x=header, path=csvout, append=FALSE)
readr::write_csv(x=FullData, path=csvout, append=TRUE, col_names=TRUE)

message('Done.')

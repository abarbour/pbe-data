#
# Method to get origin time from hfbsm/hfbsm.nfo object(s)
#
get_oct <- function(x, ...) UseMethod('get_oct')
get_oct.default <- function(x, ...){
	DT <- gsub("'", "", unlist(strsplit(x, " "))[4:6])
	strptime(sprintf("%s:%s %s", DT[1], DT[2], DT[3]), format="%Y:%j %X", tz='UTC')
}
get_oct.hfbsm <- function(x, ...){
	get_oct(attr(x, 'cmd'), ...)
}
get_oct.hfbsm.nfo <- function(x, ...){
	get_oct(x[['cmd']], ...)
}

#
# Plot method for hfbsm object (utilizes default plot syntax)
#
plot.hfbsm <- function(x, win=NULL, custom=TRUE, sc=1, ...){
	ti <- x[['Datetime']][1]
	oct <- get_oct(x)
	.panel <- if (custom){
		function(X, vm=oct-ti, ...){
			lines(X, ...)
			abline(v=vm, lty=2)
		}
	} else {
		lines
	}
	Dat <- x[['srcdat']]
	if (!is.null(win)){
		win <- sort(win)
		if (length(win)==2){
			st <- win[1]
			en <- win[2]
		} else if (length(win)==1){
			st <- NULL
			en <- win
		}
		Dat <- window(Dat, start=st, end=en)
	} 
	`Strain data` <- Dat * as.numeric(sc)[1]
	station <- attr(x, 'sta4')
	samp <- attr(x, 'frequency')
	stopifnot(frequency(Dat) == samp)
	lbl <- sprintf("%s (%s Hz%s)", station, samp, ifelse(sc!=1, sprintf(", scaled by %s", sc), ""))
	plot(`Strain data`, xlab=sprintf("Time, seconds from %s", as.character(ti)), panel=.panel, ...)
	mtext(lbl, adj=0.5, line=1)
}

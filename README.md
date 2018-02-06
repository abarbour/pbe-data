# pbe-data 

[![DOI](https://zenodo.org/badge/1277/abarbour/pbe-data.svg)](https://zenodo.org/badge/latestdoi/1277/abarbour/pbe-data)

#### Contents:
- [Description](#description)
- [Example](#example)
- [Data Access](#data-access)
- [Tables: Metadata, Peak Strains, and Bias Terms](#tables)
- [CRUST1.0 Terms](#crust10-codes)
- [Utilities](#utilities)

----

## Description

This is the full dataset of 
[Plate Boundary Observatory](http://www.unavco.org/projects/major-projects/pbo/pbo.html)
 borehole strain timeseries from Barbour and Crowell (2016) "Dynamic Strains for Earthquake Source Characterization".

For each earthquake-station pair the data are in [R](https://www.r-project.org/)'s
[binary format](https://stat.ethz.ch/R-manual/R-devel/library/base/html/save.html), with one
file (`'bsmdata.rda'`) representing the timeseries of strain, 
and another file (`'bsmdata_nfo.rda'`) representing metadata associated with the timeseries. We also include a
pdf figure of the timeseries in (`'fig_timeseries.pdf'`) for reference. 


### `bsmdata.rda`

These files contain timeseries of linear strain ( in 10<sup>-9 </sup>, or *nanostrain* ) 
for each of the four gauges at a particular station, where extension is positive. 
This can be loaded into an R environment, for example, with:

```r
> load('bsmdata.rda', verbose=TRUE)
Loading objects:
  B
```

The loaded object `B` contains the strain data and timestamps, and 
has a class and structure of:
```r
> class(B)
[1] "hfbsm" "lin"
> str(B)
List of 3
 $ srcdat  : Time-Series [1:19200, 1:4] from 1 to 961: 0 0 0.0427 0.0853 0.0853 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : NULL
  .. ..$ : chr [1:4] "CH0" "CH1" "CH2" "CH3"
 $ Datetime: POSIXct[1:19200], format: "2010-04-04 22:41:00" "2010-04-04 22:41:00" ...
 $ RelInd  : num [1:19200] 20 40 60 80 100 120 140 160 180 200 ...
 - attr(*, "sta4")= chr "B084"
 - attr(*, "file")= chr "B084.ALL_20.l.txt"
 - attr(*, "frequency")= num 20
 - attr(*, "cmd")= chr "hfbsm B084 pinyon084bcs2006 2010 094 '22:41:09' 2010 094 '22:57:48' 20 "| __truncated__
 - attr(*, "class")= chr [1:2] "hfbsm" "lin"
```

Relative strains are in `B[['srcdat']]`, which is a standard 
[`stats::ts`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/ts.html)
object:
```r
> class(B[['srcdat']])
[1] "mts"    "ts"     "matrix"
```
See `help(ts)` for more information.

Missing or bad points have a value of `NA`:

```r
> summary(B[['srcdat']])
      CH0                 CH1                CH2               CH3
 Min.   :-4536.606   Min.   :-11318.4   Min.   :-7431.4   Min.   :-8133.7
 1st Qu.:   -3.286   1st Qu.:   503.1   1st Qu.: -742.6   1st Qu.: -834.5
 Median :   49.715   Median :   578.7   Median : -691.3   Median : -783.7
 Mean   :   48.387   Mean   :   544.7   Mean   : -648.8   Mean   : -737.0
 3rd Qu.:  100.776   3rd Qu.:   642.3   3rd Qu.: -618.9   3rd Qu.: -721.4
 Max.   : 4157.278   Max.   : 14841.8   Max.   : 7151.3   Max.   : 5753.5
 NA's   :233         NA's   :177        NA's   :219       NA's   :179
```

### `bsmdata_nfo.rda`

These files contain metadata which may be useful for reconstructing the strain data, including
the command used, url of the original data, and version of python used at assembly time.
This can be loaded into an R environment, for example, with:

```r
> load('bsmdata_nfo.rda', verbose=TRUE)
Loading objects:
  b
```

The loaded object `b` contains the metadata, and has a class and structure of:

```r
> str(b)
List of 4
 $ cmd        : chr "hfbsm B084 pinyon084bcs2006 2010 094 '22:41:09' 2010 094 '22:57:48' 20 "| __truncated__
 $ cmd.success: logi TRUE
 $ results    :List of 5
  ..$ StationNames:List of 2
  .. ..$ sta4 : chr "B084"
  .. ..$ sta16: chr "pinyon084bcs2006"
  ..$ DT          :List of 2
  .. ..$ from: chr "2010 094 22 41"
  .. ..$ to  : chr "2010 094 22 57"
  ..$ SamplingHz  : num 20
  ..$ URLsrc      : chr "ftp://www.ncedc.org/pub/pbo/strain/raw/bsm/pinyon084bcs2006/2010/094"
  ..$ files       :List of 2
  .. ..$ rawfi: chr "B084.ALL_20.r.txt"
  .. ..$ linfi: chr "B084.ALL_20.l.txt"
 $ python     : chr [1:4] "CPython" "2.7.3" "('default', 'Jun 14 2013 18:17:36')" "GCC 4.2.1 (Apple Inc. build 5666) (dot 3)"
 - attr(*, "class")= chr "hfbsm.nfo"
```

The command used is in `b[['cmd']]`, for example.


## Example

Here, for example, is the timeseries at B084 for the
2010 M<sub>W</sub> 7.2 El Mayor Cucapah earthquake
showing peak strains of nearly 15 &#215; 10<sup>-6</sup> ( or 15 *microstrain* )
shown in the appropriate [fig_timeseries.pdf](2010/2010.094_7.2/B084/fig_timeseries.pdf):

![B084-El Mayor](example.png)

We have included a sample R script [`plot_bsmdata.R`](plot_bsmdata.R) to show how 
a similar version of this figure can be reproduced.


## Data Access

Download the full archive through the link above, or
use version control (git, Subversion, etc.) to maintain a local copy:

	git clone git@github.com:abarbour/pbe-data.git

The total size of this repository is on the order of 800 Mb, so the first 
fetch through `git` will take a considerable amount of time. The size can be minimized slightly 
by replacing `git clone` with `git clone --depth 1` in the expression above.


## Tables

### [earthquakes.txt](earthquakes.txt)

This table gives information regarding the origin times, locations (latitude, longitude, and
depth in km), and moment magnitudes of all the earthquakes in our search.

```fundamental
eqnum	year	mo	dy	hr	mi      sec     nlat    elon    depkm   Mw
    1	2004	1	25	15	12      28.6    49.05   -127.88 12.0    5.4
    2	2004	3	17	23	53      13.9    36.03   -121.35 12.0    4.7
    3	2004	6	15	22	28      52.4    32.45   -117.92 12.0    5.0
    4	2004	7	12	16	45      3.7     44.30   -124.71 20.0    4.9
    5	2004	7	15	12	6       54.0    49.48   -127.17 18.7    5.7
```

and so on.

*Note that this list does not indicate with BSM data is available; for this
you'll want to inspect the output of* [listFiles](#listfiles)

### [bsm_station_times.txt](bsm_station_times.txt)
	
This table gives the earthquake-station pairs by four-character station ID, origin time,
and hypocentral distance in kilometers:

```fundamental
sta4 year mo dy hr mi sec geodkm
B001 2004 1 25 15 12 29 367.79
B003 2004 1 25 15 12 29 296.98
B004 2004 1 25 15 12 29 271.42
B005 2004 1 25 15 12 29 341.16
B006 2004 1 25 15 12 29 341.36
```

and so on.


### [Earthquake_BSM_pairs.txt](Earthquake_BSM_pairs.txt)

This table is effectively a merge of `earthquakes.txt` and `bsm_station_times.txt`, except with
the addition of an earthquake identifier, the sixteen-character station ID, and the Julian day of
the origin time:

```fundamental
year mo dy hr mi sec sta4 sta16            geodkm jday eqnum nlat  elon    depkm Mw  eqid        
2004  1 25 15 12 29  B001 golbeck01bwa2005 367.79 025    1   49.05 -127.88 12.0  5.4 2004.025_5.4
2004  7 12 16 45  4  B001 golbeck01bwa2005 433.24 194    4   44.30 -124.71 20.0  4.9 2004.194_4.9
2004  7 15 12  6 54  B001 golbeck01bwa2005 337.13 197    5   49.48 -127.17 18.7  5.7 2004.197_5.7
2004  7 19  8  1 52  B001 golbeck01bwa2005 344.81 201    6   49.60 -127.19 24.8  6.3 2004.201_6.3
2004 11  2 10  2 16  B001 golbeck01bwa2005 459.27 307   14   49.17 -129.13 19.0  6.6 2004.307_6.6
```

and so on. To find the entry for the example figure given above:

```console
$ grep -E 'B084.*2010.094' Earthquake_BSM_pairs.txt
 2010  4  4 22 41  9  B084 pinyon084bcs2006 175.83 094  112   32.31 -115.39 12.8  7.2 2010.094_7.2
```

*Note the earthquake identifier is defined as `[year].[jday]_[Mw]`, with the terms
in the brackets representing field names in the tables.*


### [ObservedStrains.txt](ObservedStrains.txt)

This table gives the observed peak rms strain for each earthquake-station pair
with high-frequency strain data used in the paper. The table is 
structured as follows:

```fundamental
 Station Earthquake   Mw  D.km   logE
 B001    2005.323_5.3 5.3 429.53 -8.308648
 B001    2008.118_5.2 5.2 435.56 -8.443865
 B001    2008.238_5.1 5.1 449.24 -8.955592
 B001    2008.255_5.1 5.1 446.77 -8.629519
 B001    2008.255_5.2 5.2 447.31 -8.364227
```

and so on, with columns representing
- `Station`, the station identifier
- `Earthquake`, the earthquake identifier
- `Mw`, the moment magnitude
- `D.km`, the hypocentral distance in km
- `logE`, the observed peak rms strain (log)

Here's an example (in R) showing how
to load these data and run a linear mixed-effects model, while
accounting for both station terms and earthquake terms:

```r
> library(lme4)
> Obs <- read.table('ObservedStrains.txt', header=TRUE)
> lmer(logE ~ Mw + log10(D.km) + (1 | Station) + (1 | Earthquake), Obs)
```
giving
```r
Linear mixed model fit by REML ['lmerMod']
Formula: logE ~ Mw + log10(D.km) + (1 | Station) + (1 | Earthquake)
   Data: Obs
REML criterion at convergence: -400.6526
Random effects:
 Groups     Name        Std.Dev.
 Earthquake (Intercept) 0.2798
 Station    (Intercept) 0.1309
 Residual               0.1813
Number of obs: 1792, groups:  Earthquake, 144; Station, 68
Fixed Effects:
(Intercept)           Mw  log10(D.km)
     -9.513        1.250       -1.992
```

The *fixed* effects represent the magnitude-distance scaling,
and the *random* effects represent the station and earthquake biases.

### [BiasTerms.txt](BiasTerms.txt)

This table gives bias terms (the *random effects* in the example above) from
the linear mixed-effects models given in the paper. The table is 
structured as follows:

```fundamental
 LME                    Effect     Term         Bias      Std.error
 Station                Station    B928         -0.419    0.0671
 Station                Station    B012         -0.371    0.0651
 Station                Station    B927         -0.364    0.0671
 Station                Station    B035         -0.363    0.0337
 Station                Station    B926         -0.338    0.0693
```

and so on, with columns representing
- `LME`, the type of lme regression done ('Station', 'Earthquake', or 'Station.and.Earthquake')
- `Effect`,	the random effect group ('Station', or 'Earthquake') <sup id="a1">[&#9733;](#f1)</sup>
- `Term`, the identifier within the random effect group (i.e., the station name or earthquake ID)
- `Bias`, the fixed mean bias estimate
- `Std.error`, the standard error associated with `Bias`, from the conditional covariance matrix

Below is a list demonstrating the meaning of the `LME` field with 
the equivalent expression to run a linear mixed-effects model in R (with
the [lme4](https://cran.r-project.org/package=lme4) package):

| Value of `LME` | Equivalent expression in R |
|---------------:|:------------------------------|
| 'Station'      | `lmer(logE ~ Mw + log10(D.km) + (1 | Station), Obs)` |
| 'Earthquake'	 | `lmer(logE ~ Mw + log10(D.km) + (1 | Earthquake), Obs)` |
| 'Station.and.Earthquake' | `lmer(logE ~ Mw + log10(D.km) + (1 | Station) + (1 | Earthquake), Obs)` |

<b id="f1">&#9733;</b> Note that the `Effect` terms are the same as in other tables, so 'Station' &#10234; 'sta4' and 'Earthquake' &#10234; 'eqid'. [&#8617;](#a1)


## [CRUST1.0](http://igppweb.ucsd.edu/~gabi/crust1.html) Codes

The crustal rock-type classification codes for the BSMs are in [BSM_C1_Codes.txt](BSM_C1_Codes.txt); this table is 
structured as follows:

```fundamental
 Station C1.code.sta
 B001    L1
 B003    T-
 B004    T-
 B005    L1
 B006    L1
 B007    L1
 B009    L1
 B010    L1
```
and so on, with column `C1.code` representing the CRUST 1.0

The classification codes for the earthquakes are in [EQS_C1_Codes.txt](EQS_C1_Codes.txt), which
is structured similarly:

```fundamental
 Earthquake   C1.code.eq Oceanic.crust
 2004.025_5.4 A1         TRUE
 2004.197_5.7 A1         TRUE
 2004.201_6.3 A1         TRUE
 2004.307_5.0 A0         TRUE
 2004.307_5.1 A0         TRUE
 2004.307_5.2 A1         TRUE
 2004.307_6.6 A0         TRUE
 2004.357_5.1 A0         TRUE
```
and so on, except for an additional column (`Oceanic.crust`) representing
whether or not `C1.code` represents oceanic crust (`TRUE` == oceanic).

Here is a reference table giving the description of each value possible for
`C1.code`:

|`C1.code` | Description adapted from CRUST1.0 database |
|:--:|:-----------|
|A0| oceans 3 Myr and younger|
|A1| normal oceanic|
|B-| melt affected oceanic crust and oceanic plateaus|
|C-| continental shelf|
|D-| platform|
|E-| slow thin platform|
|F-| Archean (Antarctica)|
|G1| early Archean|
|G2| late Archean|
|H1| early/mid Proterozoic|
|H2| early/mid Proterozoic (Antarctica, slow)|
|I1| late Proterozoic|
|I2| slow late Proterozoic|
|J-| island arc|
|K-| forearc|
|L1| continental arc|
|L2| slow continental arc|
|M-| extended crust|
|N-| fast extended crust (Antarctica)|
|O-| orogen (Antarctica), thick upper crust, thin lower crust|
|P-| orogen, thick upper crust, very thin lower crust|
|Q-| orogen, thick upper crust, fast middle crust|
|R1| orogen, slow lower crust (Andes)|
|R2| slow orogen (Himalaya)|
|S-| continental slope-margin transition|
|T-| margin-continent/shield transition|
|U-| slow margin/shield (Antarctica)|
|V1| inactive ridge, Alpha Ridge|
|V2| thinned continental crust, Red Sea|
|W-| oceanic plateau with continental crust|
|X-| rift|
|Y1| Caspian depression|
|Y2| intermediate continental/oceanic crust, Black Sea|
|Y3| Caspian Sea oceanic|
|Z1| Phanerozoic|
|Z2| fast Phanerozoic (E. Australia, S. Africa, N. Siberia)|

To include these classifications into the strain regression<sup id="a1">[&#9733;](#f2)</sup>, the equivalent
expression in R would be

	lmer(logE ~ Mw + log10(D.km) + Oceanic.crust + (1 | C1.code.sta), Obs)

<b id="f2">&#9733;</b> Note that these classification tables will need to be merged with the observation table [&#8617;](#a2)


## Utilities
	
### [listFiles](listFiles) 

A bash shell script that can be used to list
files by the earthquake and station identifiers. This includes both
the raw data and metadata files:

```console
$ listFiles | head -5
eqid         sta4 type rdafile
2005.323_5.3 B001 raw  2005/2005.323_5.3/B001/bsmdata.rda
2005.323_5.3 B004 raw  2005/2005.323_5.3/B004/bsmdata.rda
2005.323_5.3 B005 raw  2005/2005.323_5.3/B005/bsmdata.rda
2005.323_5.3 B006 raw  2005/2005.323_5.3/B006/bsmdata.rda
```

```console
$ listFiles | tail -5
2014.072_5.5 B040 nfo  2014/2014.072_5.5/B040/bsmdata_nfo.rda
2014.072_5.5 B045 nfo  2014/2014.072_5.5/B045/bsmdata_nfo.rda
2014.072_5.5 B933 nfo  2014/2014.072_5.5/B933/bsmdata_nfo.rda
2014.072_5.5 B934 nfo  2014/2014.072_5.5/B934/bsmdata_nfo.rda
2014.072_5.5 B935 nfo  2014/2014.072_5.5/B935/bsmdata_nfo.rda
```

[(Top)](#pbe-data)

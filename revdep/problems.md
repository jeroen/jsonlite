# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.3 (2017-03-06) |
|system   |x86_64, darwin13.4.0         |
|ui       |X11                          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Amsterdam             |
|date     |2017-04-08                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|jsonlite |   |1.4     |2017-04-08 |local (NA/NA@NA) |

# Check results
16 packages with problems

## AWR.Kinesis (1.7.3)
Maintainer: Gergely Daroczi <gergely.daroczi@card.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘AWR.Kinesis’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/AWR.Kinesis.Rcheck/00install.out’ for details.
```

## AWR.KMS (0.1)
Maintainer: Gergely Daroczi <gergely.daroczi@card.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘AWR.KMS’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/AWR.KMS.Rcheck/00install.out’ for details.
```

## curl (2.4)
Maintainer: Jeroen Ooms <jeroen@berkeley.edu>  
Bug reports: https://github.com/jeroen/curl/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘testthat.R’ [3s/54s]
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  2. Error: Invalid domain raises an error (@test-certificates.R#6) --------------
  URL using bad/illegal format or missing URL
  1: expect_is(curl_fetch_memory(fake_url, handle = new_handle(ssl_verifyhost = FALSE))$status, 
         "integer") at testthat/test-certificates.R:6
  2: klass(object)
  3: paste(class(x), collapse = "/")
  4: curl_fetch_memory(fake_url, handle = new_handle(ssl_verifyhost = FALSE))
  
  testthat results ================================================================
  OK: 144 SKIPPED: 0 FAILED: 2
  1. Failure: Invalid domain raises an error (@test-certificates.R#5) 
  2. Error: Invalid domain raises an error (@test-certificates.R#6) 
  
  Error: testthat unit tests failed
  Execution halted
```

## d3r (0.6.2)
Maintainer: Kent Russell <kent.russell@timelyportfolio.com>  
Bug reports: https://github.com/timelyportfolio/d3r/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘testthat.R’
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > library(d3r)
  > 
  > test_check("d3r")
  1. Failure: d3_igraph works (@test_igraph.R#36) --------------------------------
  d3_igraph(bull_node_attr, json = FALSE) not equal to list(...).
  Component "links": Component "weight": Modes: character, numeric
  Component "links": Component "weight": target is character, current is numeric
  
  
  testthat results ================================================================
  OK: 9 SKIPPED: 3 FAILED: 1
  1. Failure: d3_igraph works (@test_igraph.R#36) 
  
  Error: testthat unit tests failed
  Execution halted
```

## dismo (1.1-4)
Maintainer: Robert J. Hijmans <r.hijmans@gmail.com>

1 error  | 1 warning  | 1 note 

```
checking examples ... ERROR
Running examples in ‘dismo-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: maxent
> ### Title: Maxent
> ### Aliases: maxent maxent,missing,missing-method maxent,Raster,ANY-method
> ###   maxent,SpatialGridDataFrame,ANY-method
> ###   maxent,data.frame,vector-method MaxEnt-class MaxEntReplicates-class
... 72 lines ...
+ e3
+ threshold(e3)
+ 
+ plot(e3, 'ROC')
+ 
+ }
Loading required package: rJava
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
Warning: running command '/usr/libexec/java_home' had status 1
No Java runtime present, requesting install.

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
1-DSDam
2-SegLowFlow
3-SegTSeas
4-USAvgT
5-DSMaxSlope
fitting final gbm model with a fixed number of 1350 trees for Angaus
gbm.interactions - version 2.9
... 8 lines ...
Loading required package: lattice
Loading required package: splines
Loading required package: parallel
Error : .onAttach failed in attachNamespace() for 'gbm', details:
  call: formatDL(nm, txt, indent = max(nchar(nm, "w")) + 3)
  error: incorrect values of 'indent' and 'width'

Error: processing vignette 'brt.Rnw' failed with diagnostics:
 chunk 12 (label = dismo-10) 
Error : package or namespace load failed for ‘gbm’
Execution halted

checking dependencies in R code ... NOTE
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
No Java runtime present, requesting install.
```

## fitbitScraper (0.1.7)
Maintainer: Cory Nissen <corynissen@gmail.com>

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Quitting from lines 29-40 (fitbitScraper-examples.Rmd) 
Error: processing vignette 'fitbitScraper-examples.Rmd' failed with diagnostics:
Value for option cookie (10022) must be length-1 string
Execution halted

```

## h2o (3.10.3.6)
Maintainer: Tom Kraljevic <tomk@0xdata.com>  
Bug reports: http://jira.h2o.ai

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘h2o-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: aaa
> ### Title: Starting H2O For examples
> ### Aliases: aaa
> 
> ### ** Examples
... 16 lines ...
[1] TRUE
[1] -1
[1] "Failed to connect to localhost port 54321: Connection refused"
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to localhost port 54321: Connection refused
[1] 7
Error in h2o.init() : H2O failed to start, stopping execution.
Execution halted
** found \donttest examples: check also with --run-donttest

checking installed package size ... NOTE
  installed size is 62.4Mb
  sub-directories of 1Mb or more:
    java  61.2Mb
```

## HARtools (0.0.5)
Maintainer: John Harrison <johndharrison0@gmail.com>  
Bug reports: https://github.com/johndharrison/HARtools/issues

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Quitting from lines 67-70 (Basic_use.Rmd) 
Error: processing vignette 'Basic_use.Rmd' failed with diagnostics:
HTTP error 403.
Execution halted

```

## melviewr (0.0.1)
Maintainer: Andrew Poppe <Poppe076@gmail.com>  
Bug reports: https://github.com/AndrewPoppe/melviewr/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘melviewr’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/melviewr.Rcheck/00install.out’ for details.
```

## ndtv (0.10.0)
Maintainer: Skye Bender-deMoll <skyebend@uw.edu>

1 error  | 1 warning  | 0 notes

```
checking tests ... ERROR
  Running ‘compute.animation_tests.R’
  Running ‘d3_animation_tests.R’
  Running ‘effects_tests.R’
  Running ‘filmstrip_tests.R’
  Running ‘layout_tests.R’
  Running ‘networkAnimationTest.R’
  Running ‘proximity.timeline_test.R’
Running the tests in ‘tests/proximity.timeline_test.R’ failed.
Last 13 lines of output:
  
  > if(!is.null(has.mdsj)){
  + proximity.timeline(cls33_10_16_96,onsets=seq(0,45,5),termini=seq(2.5,47.5,5),mode='MDSJ')
  + }
  collapsing slice networks ...
  computing vertex positions using 1D MDSJ layout ...
    computing positions for slice 1
  No Java runtime present, requesting install.
  [1] NA
  Error in network.layout.animate.MDSJ(net = slice, dist.mat = mat, seed.coords = prev_ycoord,  : 
    Unable to parse coordinates returned MDSJ java code
  Calls: proximity.timeline -> network.layout.animate.MDSJ
  In addition: Warning message:
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmpo4y4Xh/matrixa05858b86e5b.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmpo4y4Xh/coordsa058345545de.txt' had status 1 
  Execution halted

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
For license and citation information see statnet.org/attribution
or type citation("tergm").

installing MDSJ to directory /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/
trying URL 'http://algo.uni-konstanz.de/software/mdsj/mdsj.jar'
Content type 'application/java-archive' length 18203 bytes (17 KB)
==================================================
... 8 lines ...
 USE RESTRICTIONS: Creative Commons License 'by-nc-sa' 3.0.

Calculating layout for network slice from time  75 to 76
No Java runtime present, requesting install.
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpAKA7SN/matrixa0d019d8b0cd.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpAKA7SN/coordsa0d0613f6ffc.txt' had status 1

Error: processing vignette 'ndtv.Rnw' failed with diagnostics:
 chunk 10 (label = calc_params) 
Error in layout.fun(slice, dist.mat = dist.mat, default.dist = default.dist,  : 
  Unable to parse coordinates returned MDSJ java code
Execution halted
```

## red (1.0.0)
Maintainer: Pedro Cardoso <pedro.cardoso@helsinki.fi>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘red’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/red.Rcheck/00install.out’ for details.
```

## SensusR (2.0.0)
Maintainer: Matthew S. Gerber <gerber.matthew@gmail.com>

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘SensusR-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: plot.LocationDatum
> ### Title: Plot location data.
> ### Aliases: plot.LocationDatum
> 
> ### ** Examples
... 188 lines ...
[1] "57% done merging data for WlanDatum (4 of 7)."
[1] "71% done merging data for WlanDatum (5 of 7)."
[1] "85% done merging data for WlanDatum (6 of 7)."
[1] "100% done merging data for WlanDatum (7 of 7)."
[1] "Creating data frame for WlanDatum."
> plot(data$LocationDatum)
Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=38.0676352725243,-78.9510441850485&zoom=10&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=38.0676352725243,-78.9510441850485&sensor=false
Error: GeomRasterAnn was built with an incompatible version of ggproto.
Please reinstall the package that provides this extension.
Execution halted
```

## stplanr (0.1.7-3)
Maintainer: Robin Lovelace <rob00x@gmail.com>  
Bug reports: https://github.com/ropensci/stplanr/issues

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
No Java runtime present, requesting install.

```

## taxize (0.8.4)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/taxize/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘test-all.R’ [2s/187s]
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  
  
  3. Failure: taxon with no data returned from classification() works (@test-tax_name.R#54) 
  `warnings` does not match "no hierarchy data found in ITIS".
  Actual value: "Unknown or uninitialised column: 'itisTerms'."
  
  
  testthat results ================================================================
  OK: 25 SKIPPED: 151 FAILED: 3
  1. Failure: taxon with no data returned from classification() works (@test-tax_name.R#42) 
  2. Failure: taxon with no data returned from classification() works (@test-tax_name.R#48) 
  3. Failure: taxon with no data returned from classification() works (@test-tax_name.R#54) 
  
  Error: testthat unit tests failed
  Execution halted
```

## trackeR (0.0.5)
Maintainer: Hannah Frick <h.frick@ucl.ac.uk>  
Bug reports: https://github.com/hfrick/trackeR/issues

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Loading required package: zoo

Attaching package: 'zoo'

The following objects are masked from 'package:base':

    as.Date, as.Date.numeric

Loading required package: ggplot2

Attaching package: 'trackeR'

The following object is masked from 'package:base':

    append

Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=57.157231,-2.104296&zoom=13&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
Quitting from lines 90-91 (TourDetrackeR.Rmd) 
Error: processing vignette 'TourDetrackeR.Rmd' failed with diagnostics:
GeomRasterAnn was built with an incompatible version of ggproto.
Please reinstall the package that provides this extension.
Execution halted

```

## x.ent (1.1.6)
Maintainer: Tien T. Phan <phantien84@gmail.com>  
Bug reports: https://github.com/win-stub/x.ent/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘x.ent’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/x.ent.Rcheck/00install.out’ for details.
```


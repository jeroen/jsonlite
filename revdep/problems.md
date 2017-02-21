# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.2 (2016-10-31) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (1.0.136)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Amsterdam             |
|date     |2017-02-21                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|jsonlite |   |1.3     |2017-02-21 |local (NA/NA@NA) |

# Check results
21 packages with problems

## AWR.KMS (0.1)
Maintainer: Gergely Daroczi <gergely.daroczi@card.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘AWR.KMS’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/AWR.KMS.Rcheck/00install.out’ for details.
```

## biomartr (0.3.0)
Maintainer: Hajk-Georg Drost <hgd23@cam.ac.uk>  
Bug reports: https://github.com/HajkD/biomartr/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘biomaRt’ ‘Biostrings’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## ChemoSpec (4.4.17)
Maintainer: Bryan A. Hanson <hanson@depauw.edu>  
Bug reports: https://github.com/bryanhanson/ChemoSpec/issues

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘ChemoSpec-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: clupaSpectra
> ### Title: Hierarchical Cluster-Based Peak Alignment on a Spectra Object
> ### Aliases: clupaSpectra
> ### Keywords: utilities
> 
> ### ** Examples
> 
> 
> data(alignMUD)
> 
> plotSpectra(alignMUD, which = 1:20, lab.pos = 4.5, offset = 0.1,
+   yrange = c(0, 1900), amp = 500, xlim = c(1.5, 1.8),
+   main = "Misaligned NMR Spectra (alignMUD)")
> 
> aMUD <- clupaSpectra(alignMUD)
Error in clupaSpectra(alignMUD) : 
  You need to install package speaq to use this function
Execution halted

checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘chemometrics’, ‘mvoutlier’
```

## crunch (1.14.4)
Maintainer: Neal Richardson <neal@crunch.io>  
Bug reports: https://github.com/Crunch-io/rcrunch/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  1. Failure: Basic box with metadata and filters (@test-crunchbox.R#71) 
  2. Failure: Select variables in box (@test-crunchbox.R#79) 
  3. Failure: Hidden variables are automatically 'selected' out (@test-crunchbox.R#91) 
  4. Failure: Select filters in box (@test-crunchbox.R#101) 
  5. Failure: Select filters in box (@test-crunchbox.R#107) 
  6. Failure: is.archived setter (@test-dataset-catalog.R#62) 
  7. Failure: is.archived setter (@test-dataset-catalog.R#65) 
  8. Failure: is.published setter (@test-dataset-catalog.R#70) 
  9. Failure: is.published setter (@test-dataset-catalog.R#73) 
  1. ...
  
  Error: testthat unit tests failed
  Execution halted
```

## d3r (0.6.1)
Maintainer: Kent Russell <kent.russell@timelyportfolio.com>  
Bug reports: https://github.com/timelyportfolio/d3r/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  Component "links": Component 3: Component 3: target is character, current is numeric
  Component "links": Component 4: Component 3: Modes: character, numeric
  Component "links": Component 4: Component 3: target is character, current is numeric
  Component "links": Component 5: Component 3: Modes: character, numeric
  Component "links": Component 5: Component 3: target is character, current is numeric
  
  
  testthat results ================================================================
  OK: 9 SKIPPED: 2 FAILED: 1
  1. Failure: d3_igraph works (@test_igraph.R#36) 
  
  Error: testthat unit tests failed
  Execution halted
```

## dataone (2.0.1)
Maintainer: Matthew B. Jones <jones@nceas.ucsb.edu>  
Bug reports: https://github.com/DataONEorg/rdataone/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > test_check("dataone")
  Loading required package: dataone
  1. Failure: CNode object index query works with query list param (@test.D1Node.R#37) 
  result[[1]]$abstract does not match "chlorophyll".
  Actual value: "Two YSI water quality sondes and loggers were installed onto a navigation light pole in Kentucky Lake KY, one at a depth of one meter below the lake surface, the other at one meter above the lake bottom in February 2005.  Water Temperature, pH, dissolved oxygen, conductivity, oxidation reduction potential, and turbidity data are collected from each sonde every 15 minutes.  Chlorophyll a data are collected from the one meter depth.  Lake elevations are estimated from depth data collected from the sonde anchored near the lake bottom."
  
  
  testthat results ================================================================
  OK: 197 SKIPPED: 31 FAILED: 1
  1. Failure: CNode object index query works with query list param (@test.D1Node.R#37) 
  
  Error: testthat unit tests failed
  Execution halted
```

## dismo (1.1-4)
Maintainer: Robert J. Hijmans <r.hijmans@gmail.com>

1 error  | 0 warnings | 1 note 

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

## h2o (3.10.3.3)
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

## httr (1.2.1)
Maintainer: Hadley Wickham <hadley@rstudio.com>

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  y[1]: "eyJpc3MiOiI3NjEzMjY3OTgwNjktcjVtbGpsbG4xcmQ0bHJiaGc3NWVmZ2lncDM2bTc4ajVAZ
  y[1]: GV2ZWxvcGVyLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJzY29wZSI6Imh0dHBzOi8vd3d3Lmdvb2d
  y[1]: sZWFwaXMuY29tL2F1dGgvcHJlZGljdGlvbiIsImF1ZCI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ
  y[1]: 2xlLmNvbS9vL29hdXRoMi90b2tlbiIsImV4cCI6MTMyODU1NDM4NSwiaWF0IjoxMzI4NTUwNzg
  y[1]: 1fQ"
  
  
  testthat results ================================================================
  OK: 113 SKIPPED: 2 FAILED: 1
  1. Failure: reference claimset yields expected base64 (@test-oauth-server-side.R#20) 
  
  Error: testthat unit tests failed
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
Running the tests in ‘tests/proximity.timeline_test.R’ failed.
Last 13 lines of output:
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
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmp4hYjrv/matrixd048243fdcae.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmp4hYjrv/coordsd0485cb13619.txt' had status 1 
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
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmprqF7fO/matrixd0db13751545.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmprqF7fO/coordsd0db6bc76efd.txt' had status 1

Error: processing vignette 'ndtv.Rnw' failed with diagnostics:
 chunk 10 (label = calc_params) 
Error in layout.fun(slice, dist.mat = dist.mat, default.dist = default.dist,  : 
  Unable to parse coordinates returned MDSJ java code
Execution halted
```

## protolite (1.5)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: https://github.com/jeroenooms/protolite/issues

0 errors | 1 warning  | 0 notes

```
checking whether package ‘protolite’ can be installed ... WARNING
Found the following significant warnings:
  Warning: protoc version libprotoc 3.0.0 might not match libproto version 3.0.2.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/protolite.Rcheck/00install.out’ for details.
```

## refimpact (0.1.0)
Maintainer: Perry Stephenson <perry.stephenson+cran@gmail.com>  
Bug reports: https://github.com/perrystephenson/refimpact/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  6: fromJSON_string(txt = txt, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame, 
         simplifyMatrix = simplifyMatrix, flatten = flatten, ...)
  7: parseJSON(txt, bigint_as_char)
  8: parse_con(txt, 1024^2, bigint_as_char)
  9: open(con, "rb")
  10: open.connection(con, "rb")
  
  testthat results ================================================================
  OK: 28 SKIPPED: 0 FAILED: 1
  1. Error: get_institutions() returns a tibble (@test_institutions.R#6) 
  
  Error: testthat unit tests failed
  Execution halted
```

## RPresto (1.2.1)
Maintainer: Onur Ismail Filiz <onur@fb.com>  
Bug reports: https://github.com/prestodb/RPresto/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
         status_code = 0, data = data.frame.with.all.classes())[["response"]]) at testthat/test-get.state.R:18
  2: jsonlite::fromJSON(text.content, simplifyVector = FALSE)
  
  testthat results ================================================================
  OK: 208 SKIPPED: 25 FAILED: 5
  1. Error: dbFetch rbind works correctly (@test-dbFetch.R#214) 
  2. Error: dbFetch rbind works with zero row chunks (@test-dbFetch.R#263) 
  3. Failure: dbGetQuery works with mock (@test-dbGetQuery.R#45) 
  4. Error: extract.data works (@test-extract.data.R#45) 
  5. Error: get.state works (@test-get.state.R#18) 
  
  Error: testthat unit tests failed
  Execution halted
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

## V8 (1.2)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: https://github.com/jeroenooms/v8/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘V8’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/V8.Rcheck/00install.out’ for details.
```

## vegalite (0.6.1)
Maintainer: Bob Rudis <bob@rudis.net>  
Bug reports: https://github.com/hrbrmstr/vegalite/issues

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘vegalite-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: from_spec
> ### Title: Take a JSON Vega-Lite Spec and render as an htmlwidget
> ### Aliases: from_spec
> 
> ### ** Examples
> 
> from_spec("http://rud.is/dl/embedded.json")
Error in file(con, "r") : cannot open the connection
Calls: from_spec -> readLines -> file
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


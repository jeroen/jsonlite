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
|date     |2017-02-22                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|jsonlite |   |1.3     |2017-02-22 |local (NA/NA@NA) |

# Check results
18 packages with problems

## AWR.KMS (0.1)
Maintainer: Gergely Daroczi <gergely.daroczi@card.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘AWR.KMS’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/AWR.KMS.Rcheck/00install.out’ for details.
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
Quitting from lines 104-108 (Basic_use.Rmd) 
Error: processing vignette 'Basic_use.Rmd' failed with diagnostics:
embedded nul in string: '"(function(){\\nif(!google.nocsixjs&&google.timers&&google.timers.load.t)google.timers.load.t.xjses=(new Date).getTime();\\n})();\\n(function(){\\ngoogle.isOpera=false;google.isIE=false;google.isSafari=false;\\ngoogle.xhr=function(){var a=null;try{a=new XMLHttpRequest}catch(d){}return a};\\ngoogle.getComputedStyle=function(a,d,c){var b=c?\\"\\":0;var e=document.defaultView&&document.defaultView.getComputedStyle(a,\\"\\");b=e.getPropertyValue(d);b=c?b:parseInt(b,10);return b};google.getHeight=function(a){return google.getComputedStyle(a,\\"height\\")};google.getWidth=function(a){return google.getComputedStyle(a,\\"width\\")};google.getPageOffsetTop=function(a){return a.offsetTop+(a.offsetParent?google.getPageOffsetTop(a.offsetParent):0)};\\ngoogle.getPageOffsetLeft=function(a){return a.offsetLeft+(a.offsetParent?google.getPageOffsetLeft(a.offsetParent):0)};google.getPageOffsetStart=function(a){
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
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmp2XnCpx/matrixf22549b12083.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmp2XnCpx/coordsf225bcd9e41.txt' had status 1 
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
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmpln9nCX/matrixf2a218af69ca.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//Rtmpln9nCX/coordsf2a2244a596f.txt' had status 1

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

## wikipediatrend (1.1.10)
Maintainer: Peter Meissner <retep.meissner@gmail.com>  
Bug reports: https://github.com/petermeissner/wikipediatrend/issues

1 error  | 1 warning  | 1 note 

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  
  
  Error in curl::curl_fetch_memory(url, handle = handle) : 
    Timeout was reached
  Error in curl::curl_fetch_memory(url, handle = handle) : 
    Timeout was reached
  testthat results ================================================================
  OK: 66 SKIPPED: 0 FAILED: 2
  1. Failure: normal usage (@test_caching_gathering.R#27) 
  2. Failure: setting cache file (@test_caching_gathering.R#39) 
  
  Error: testthat unit tests failed
  Execution halted

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Error in curl::curl_fetch_memory(url, handle = handle) : 
  Timeout was reached
http://stats.grok.se/json/en/201510/Main_page

data from server was: Error in curl::curl_fetch_memory(url, handle = handle) : 
  Timeout was reached


Error in curl::curl_fetch_memory(url, handle = handle) : 
  Timeout was reached
http://stats.grok.se/json/en/201511/Main_page

data from server was: Error in curl::curl_fetch_memory(url, handle = handle) : 
  Timeout was reached


Quitting from lines 108-112 (using-wikipediatrend.Rmd) 
Error: processing vignette 'using-wikipediatrend.Rmd' failed with diagnostics:
need finite 'xlim' values
Execution halted


checking package dependencies ... NOTE
Packages suggested but not available for checking:
  ‘AnomalyDetection’ ‘BreakoutDetection’
```

## worrms (0.1.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/worrms/issues

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘worrms-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: wm_children
> ### Title: Get children for an AphiaID
> ### Aliases: wm_children
> 
> ### ** Examples
> 
> wm_children(id = 105706)
Error: Bad Gateway (HTTP 502).
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


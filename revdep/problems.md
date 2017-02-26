# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.2 (2016-10-31) |
|system   |x86_64, darwin13.4.0         |
|ui       |X11                          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Amsterdam             |
|date     |2017-02-26                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|jsonlite |   |1.3     |2017-02-26 |local (NA/NA@NA) |

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
  1.  Failure: D1Client d1SolrQuery works (@test.D1Client.R#334) 
  2.  Error: D1Client d1SolrQuery works (@test.D1Client.R#335) 
  3.  Failure: D1Client d1IdentifierSearch works (@test.D1Client.R#365) 
  4.  Failure: D1Client d1IdentifierSearch works (@test.D1Client.R#366) 
  5.  Failure: CNode object index query works with query list param (@test.D1Node.R#25) 
  6.  Error: CNode object index query works with query list param (@test.D1Node.R#26) 
  7.  Failure: listQueryEngines, getQueryEngineDescription works for CNode, MNode (@test.D1Node.R#107) 
  8.  Error: listQueryEngines, getQueryEngineDescription works for CNode, MNode (@test.D1Node.R#108) 
  9.  Failure: CNode object index query works with query string param (@test.D1Node.R#138) 
  10. Error: CNode object index query works with query string param (@test.D1Node.R#139) 
  
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

## eurostat (2.2.43)
Maintainer: Leo Lahti <louhos@googlegroups.com>  
Bug reports: https://github.com/ropengov/eurostat/issues

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Loading required package: xml2
trying URL 'http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Ftsdtr210.tsv.gz'
Content type 'application/octet-stream;charset=UTF-8' length 4136 bytes
==================================================
downloaded 4136 bytes

Table tsdtr210 cached at /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpZbMS1f/eurostat/tsdtr210_num_code_TF.rds
trying URL 'http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=data%2Ftgs00026.tsv.gz'
Content type 'application/octet-stream;charset=UTF-8' length 5933 bytes
==================================================
downloaded 5933 bytes

Quitting from lines 252-268 (eurostat_tutorial.Rmd) 
Error: processing vignette 'eurostat_tutorial.Rmd' failed with diagnostics:
cannot open the connection
Execution halted

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
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpZyS8oj/matrixa3cb128a3653.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpZyS8oj/coordsa3cb2ff48ca7.txt' had status 1 
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
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpwlENE9/matrixa47141608a4f.txt /var/folders/pv/clp8mkdn6qqf5d04qqfw4xj80000gn/T//RtmpwlENE9/coordsa47129186a11.txt' had status 1

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

## red (1.0.0)
Maintainer: Pedro Cardoso <pedro.cardoso@helsinki.fi>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘red’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/red.Rcheck/00install.out’ for details.
```

## refimpact (0.1.0)
Maintainer: Perry Stephenson <perry.stephenson+cran@gmail.com>  
Bug reports: https://github.com/perrystephenson/refimpact/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  9: open(con, "rb")
  10: open.connection(con, "rb")
  
  testthat results ================================================================
  OK: 21 SKIPPED: 0 FAILED: 5
  1. Error: get_institutions() returns a tibble (@test_institutions.R#6) 
  2. Error: Function returns sensible data frames for sensible queries (@test_search_case_studies.R#6) 
  3. Error: get_tag_types() returns a tibble (@test_tag_types.R#6) 
  4. Error: get_tag_value() returns a tibble (@test_tag_values.R#6) 
  5. Error: get_units_of_assessment() returns a tibble (@test_units_of_assessment.R#6) 
  
  Error: testthat unit tests failed
  Execution halted
```

## rgeospatialquality (0.3.2)
Maintainer: Javier Otegui <javier.otegui@gmail.com>  
Bug reports: https://github.com/ropenscilabs/rgeospatialquality/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  1. Failure: add_flags works properly guessing names for rvertnet dataset (@test_multiple_records.R#38) 
  2. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#51) 
  3. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#52) 
  4. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#53) 
  5. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#54) 
  6. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#55) 
  7. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#56) 
  8. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#57) 
  9. Failure: add_flags works properly with a 1-row data.frame (@test_multiple_records.R#58) 
  1. ...
  
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

## x.ent (1.1.6)
Maintainer: Tien T. Phan <phantien84@gmail.com>  
Bug reports: https://github.com/win-stub/x.ent/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘x.ent’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/x.ent.Rcheck/00install.out’ for details.
```


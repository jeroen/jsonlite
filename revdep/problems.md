# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.4.0 (2017-04-21) |
|system   |x86_64, darwin15.6.0         |
|ui       |X11                          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Amsterdam             |
|date     |2017-05-31                   |

## Packages

|package  |*  |version |date       |source                     |
|:--------|:--|:-------|:----------|:--------------------------|
|jsonlite |   |1.5     |2017-05-31 |local (jeroen/jsonlite@NA) |

# Check results

19 packages with problems

|package       |version  | errors| warnings| notes|
|:-------------|:--------|------:|--------:|-----:|
|AWR.Kinesis   |1.7.3    |      1|        0|     0|
|AWR.KMS       |0.1      |      1|        0|     0|
|biomartr      |0.5.1    |      1|        0|     0|
|BoSSA         |2.1      |      0|        1|     1|
|ChemoSpec     |4.4.17   |      1|        0|     2|
|d3r           |0.6.5    |      1|        0|     0|
|devtools      |1.13.1   |      1|        0|     1|
|EventStudy    |0.30     |      0|        1|     0|
|fitbitScraper |0.1.8    |      0|        1|     0|
|h2o           |3.10.4.6 |      1|        0|     1|
|lawn          |0.3.0    |      1|        0|     0|
|melviewr      |0.0.1    |      1|        0|     0|
|ndtv          |0.10.0   |      1|        1|     0|
|postGIStools  |0.2.1    |      1|        0|     0|
|protolite     |1.6      |      1|        0|     1|
|ropenaq       |0.2.0    |      1|        0|     0|
|RSocrata      |1.7.2-12 |      1|        0|     0|
|stplanr       |0.1.7-3  |      0|        1|     1|
|V8            |1.5      |      1|        0|     0|

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

## biomartr (0.5.1)
Maintainer: Hajk-Georg Drost <hgd23@cam.ac.uk>  
Bug reports: https://github.com/HajkD/biomartr/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘biomaRt’ ‘Biostrings’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## BoSSA (2.1)
Maintainer: pierre lefeuvre <pierre.lefeuvre@cirad.fr>

0 errors | 1 warning  | 1 note 

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Error: processing vignette 'bossa-analysis.Rmd' failed with diagnostics:
there is no package called ‘BiocStyle’
Execution halted


checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘BiocStyle’ ‘phyloseq’
```

## ChemoSpec (4.4.17)
Maintainer: Bryan A. Hanson <hanson@depauw.edu>  
Bug reports: https://github.com/bryanhanson/ChemoSpec/issues

1 error  | 0 warnings | 2 notes

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

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘speaq’

checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘chemometrics’, ‘mvoutlier’
```

## d3r (0.6.5)
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
  OK: 9 SKIPPED: 4 FAILED: 1
  1. Failure: d3_igraph works (@test_igraph.R#36) 
  
  Error: testthat unit tests failed
  Execution halted
```

## devtools (1.13.1)
Maintainer: Hadley Wickham <hadley@rstudio.com>  
Bug reports: https://github.com/hadley/devtools/issues

1 error  | 0 warnings | 1 note 

```
checking tests ... ERROR
  Running ‘has-devel.R’
  Running ‘test-that.R’ [46s/54s]
Running the tests in ‘tests/test-that.R’ failed.
Last 13 lines of output:
  "rcpp_hello_world" not available for .Call() for package "testDllRcpp"
  1: expect_true(is.list(rcpp_hello_world())) at testthat/test-dll.r:113
  2: expect(identical(as.vector(object), TRUE), sprintf("%s isn't true.", lab), info = info)
  3: as.expectation(exp, ..., srcref = srcref)
  4: identical(as.vector(object), TRUE)
  5: as.vector(object)
  6: rcpp_hello_world()
  
  
  testthat results ================================================================
  OK: 391 SKIPPED: 9 FAILED: 1
  1. Error: load_all() can compile and load DLLs linked to Rcpp (@test-dll.r#113) 
  
  Error: testthat unit tests failed
  Execution halted

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘BiocInstaller’
```

## EventStudy (0.30)
Maintainer: Dr. Simon Mueller <simon.mueller@muon-stat.com>  
Bug reports: https://github.com/EventStudyTools/api-wrapper.r/issues

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Error: processing vignette 'addin_eventstudy.Rmd' failed with diagnostics:
there is no package called ‘prettydoc’
Execution halted

```

## fitbitScraper (0.1.8)
Maintainer: Cory Nissen <corynissen@gmail.com>

0 errors | 1 warning  | 0 notes

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Quitting from lines 22-24 (fitbitScraper-examples.Rmd) 
Error: processing vignette 'fitbitScraper-examples.Rmd' failed with diagnostics:
login failed
Execution halted

```

## h2o (3.10.4.6)
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
... 20 lines ...
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
  installed size is 64.1Mb
  sub-directories of 1Mb or more:
    java  62.9Mb
```

## lawn (0.3.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/lawn/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘test-all.R’
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  Actual value: "c++ exception (unknown reason)"
  
  
  2. Failure: lawn_centroid fails correctly (@test-centroid.R#50) ----------------
  error$message does not match "Unexpected number".
  Actual value: "c++ exception (unknown reason)"
  
  
  testthat results ================================================================
  OK: 805 SKIPPED: 0 FAILED: 2
  1. Failure: lawn_centroid fails correctly (@test-centroid.R#47) 
  2. Failure: lawn_centroid fails correctly (@test-centroid.R#50) 
  
  Error: testthat unit tests failed
  Execution halted
```

## melviewr (0.0.1)
Maintainer: Andrew Poppe <Poppe076@gmail.com>  
Bug reports: https://github.com/AndrewPoppe/melviewr/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Packages required but not available: ‘gWidgetsRGtk2’ ‘RGtk2’ ‘cairoDevice’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
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
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/m5/mf16p5417vqbykm9jckq5_5w0000gn/T//RtmpExxLbL/matrix13a54589f1f74.txt /var/folders/m5/mf16p5417vqbykm9jckq5_5w0000gn/T//RtmpExxLbL/coords13a5436ca2620.txt' had status 1 
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
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/m5/mf16p5417vqbykm9jckq5_5w0000gn/T//Rtmp6yDyBO/matrix13b1530d751e9.txt /var/folders/m5/mf16p5417vqbykm9jckq5_5w0000gn/T//Rtmp6yDyBO/coords13b15842b10c.txt' had status 1

Error: processing vignette 'ndtv.Rnw' failed with diagnostics:
 chunk 10 (label = calc_params) 
Error in layout.fun(slice, dist.mat = dist.mat, default.dist = default.dist,  : 
  Unable to parse coordinates returned MDSJ java code
Execution halted
```

## postGIStools (0.2.1)
Maintainer: Philippe Marchand <pmarchand@sesync.org>  
Bug reports: https://github.com/SESYNC-ci/postGIStools/issues

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘RPostgreSQL’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## protolite (1.6)
Maintainer: Jeroen Ooms <jeroen@berkeley.edu>  
Bug reports: https://github.com/jeroen/protolite/issues

1 error  | 0 warnings | 1 note 

```
checking whether package ‘protolite’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/protolite.Rcheck/00install.out’ for details.

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘RProtoBuf’
```

## ropenaq (0.2.0)
Maintainer: Maëlle Salmon <maelle.salmon@yahoo.se>  
Bug reports: http://github.com/ropensci/ropenaq/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘testthat.R’ [2s/248s]
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  2: getResults(urlAQ, argsList)
  3: getResults_bypage(urlAQ, argsList)
  4: treat_res(res)
  5: jsonlite::fromJSON(contentPage)
  6: fromJSON_string(txt = txt, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame, 
         simplifyMatrix = simplifyMatrix, flatten = flatten, ...)
  7: parseJSON(txt, bigint_as_char)
  8: parse_string(txt, bigint_as_char)
  
  testthat results ================================================================
  OK: 6 SKIPPED: 16 FAILED: 1
  1. Error: Queries work with spaces and accents (@test-buildQueries.R#56) 
  
  Error: testthat unit tests failed
  Execution halted
```

## RSocrata (1.7.2-12)
Maintainer: "Tom Schenk Jr." <developers@cityofchicago.org>  
Bug reports: https://github.com/Chicago/RSocrata/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
  Running ‘testthat.R’ [9s/76s]
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  2017-05-31 14:31:44.149 getResponse: Error in httr GET: 403  https://soda.demo.socrata.com/resource/a9g2-feh2.csv?$order=:id
  2017-05-31 14:31:45.059 getResponse: Error in httr GET: 403  https://soda.demo.socrata.com/resource/a9g2-feh2.json?$order=:id
  1. Failure: converts money fields to numeric (@test-all.R#471) -----------------
  "numeric" not equal to class(df$Employee.Annual.Salary).
  1/1 mismatches
  x[1]: "numeric"
  y[1]: "NULL"
  
  
  testthat results ================================================================
  OK: 156 SKIPPED: 0 FAILED: 1
  1. Failure: converts money fields to numeric (@test-all.R#471) 
  
  Error: testthat unit tests failed
  Execution halted
```

## stplanr (0.1.7-3)
Maintainer: Robin Lovelace <rob00x@gmail.com>  
Bug reports: https://github.com/ropensci/stplanr/issues

0 errors | 1 warning  | 1 note 

```
checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
Quitting from lines 108-113 (introducing-stplanr.Rmd) 
Error: processing vignette 'introducing-stplanr.Rmd' failed with diagnostics:
OpenStreetMap package needed for this function to work. Please install it.
Execution halted


checking compiled code ... NOTE
File ‘stplanr/libs/stplanr.so’:
  Found no calls to: ‘R_registerRoutines’, ‘R_useDynamicSymbols’

It is good practice to register native routines and to disable symbol
search.

See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual.
```

## V8 (1.5)
Maintainer: Jeroen Ooms <jeroen@berkeley.edu>  
Bug reports: https://github.com/jeroen/v8/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘V8’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/V8.Rcheck/00install.out’ for details.
```


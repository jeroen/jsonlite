# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.1 (2016-06-21) |
|system   |x86_64, darwin13.4.0         |
|ui       |X11                          |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |Europe/Amsterdam             |
|date     |2016-06-30                   |

## Packages

|package  |*  |version |date       |source           |
|:--------|:--|:-------|:----------|:----------------|
|jsonlite |   |1.0     |2016-06-30 |local (NA/NA@NA) |

# Check results
13 packages with problems

## ChemoSpec (4.3.17)
Maintainer: Bryan A. Hanson <hanson@depauw.edu>  
Bug reports: https://github.com/bryanhanson/ChemoSpec/issues

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘ChemoSpec-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: clupaSpectra
> ### Title: Conduct Hierarchical Cluster-Based Peak Alignment on a Spectra
> ###   Object
> ### Aliases: clupaSpectra
> ### Keywords: utilities
> 
> ### ** Examples
> 
> data(alignMUD)
> plotSpectra(alignMUD, which = 1:20, lab.pos = 4.5, offset = 0.1,
+ 	yrange = c(0, 1900), amp = 500, xlim = c(1.5, 1.8),
+ 	main = "Misaligned NMR Spectra (alignMUD)")
> aMUD <- clupaSpectra(alignMUD)
Error in clupaSpectra(alignMUD) : 
  You need to install package speaq to use this function
Execution halted

checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘chemometrics’, ‘mvoutlier’
```

## curl (0.9.7)
Maintainer: Jeroen Ooms <jeroen.ooms@stat.ucla.edu>  
Bug reports: https://github.com/jeroenooms/curl/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  
  testthat results ================================================================
  OK: 70 SKIPPED: 0 FAILED: 4
  1. Failure: Delete a cookie (@test-cookies.R#26) 
  2. Failure: Delete a cookie (@test-cookies.R#28) 
  3. Failure: Redirect (@test-handle.R#13) 
  4. Error: Compression (@test-handle.R#28) 
  
  Error: testthat unit tests failed
  In addition: Warning messages:
  1: closing unused connection 4 (http://httpbin.org/gzip) 
  2: closing unused connection 3 (http://httpbin.org/deflate) 
  Execution halted
```

## dismo (1.1-1)
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

checking sizes of PDF files under ‘inst/doc’ ... WARNING
  ‘gs+qpdf’ made some significant size reductions:
     compacted ‘sdm.pdf’ from 1182Kb to 882Kb
  consider running tools::compactPDF(gs_quality = "ebook") on these files

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

## futile.logger (1.4.1)
Maintainer: Brian Lee Yung Rowe <r@zatonovo.com>

1 error  | 0 warnings | 1 note 

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > library(testthat)
  > test_check("futile.logger")
  Loading required package: futile.logger
  1. Failure: lower levels are not logged (@test_debug.R#19) ---------------------
  flog.trace("testlog") produced no output
  
  
  testthat results ================================================================
  OK: 68 SKIPPED: 0 FAILED: 1
  1. Failure: lower levels are not logged (@test_debug.R#19) 
  
  Error: testthat unit tests failed
  Execution halted

checking R code for possible problems ... NOTE
.log_level: no visible global function definition for ‘capture.output’
flog.namespace: no visible global function definition for
  ‘capture.output’
flog.namespace: no visible global function definition for ‘str’
Undefined global functions or variables:
  capture.output str
Consider adding
  importFrom("utils", "capture.output", "str")
to your NAMESPACE file.
```

## ggvis (0.4.2)
Maintainer: Winston Chang <winston@rstudio.com>

1 error  | 0 warnings | 1 note 

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  [8] 7 - 2 == 5
  [9] 7 - 2 == 5
  ...
  
  
  testthat results ================================================================
  OK: 444 SKIPPED: 0 FAILED: 1
  1. Failure: Automatic width (@test-compute-bin.r#143) 
  
  Error: testthat unit tests failed
  In addition: Warning message:
  In bind_rows_(x, .id) : Unequal factor levels: coercing to character
  Execution halted

checking R code for possible problems ... NOTE
adjust_breaks: no visible global function definition for ‘median’
bin_params.POSIXct: no visible global function definition for ‘is’
bin_vector.POSIXct: no visible global function definition for ‘is’
combine_data_props: no visible global function definition for
  ‘setNames’
combine_data_props : <anonymous>: no visible global function definition
  for ‘setNames’
compute_boxplot.data.frame: no visible global function definition for
  ‘quantile’
... 24 lines ...
  ‘packageVersion’
Undefined global functions or variables:
  complete.cases formula is median na.omit packageVersion predict qt
  quantile runif setNames terms
Consider adding
  importFrom("methods", "is")
  importFrom("stats", "complete.cases", "formula", "median", "na.omit",
             "predict", "qt", "quantile", "runif", "setNames", "terms")
  importFrom("utils", "packageVersion")
to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
contains 'methods').
```

## h2o (3.8.2.6)
Maintainer: Tom Kraljevic <tomk@0xdata.com>

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
  installed size is 57.1Mb
  sub-directories of 1Mb or more:
    java  56.1Mb
```

## httr (1.2.0)
Maintainer: Hadley Wickham <hadley@rstudio.com>

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  Loading required package: httr
  1. Error: headers returned as expected (@test-response.r#41) -------------------
  attempt to set an attribute on NULL
  1: expect_equal(round_trip(a = "a + b")$a, "a + b") at testthat/test-response.r:41
  2: compare(object, expected, ...)
  3: round_trip(a = "a + b")
  
  testthat results ================================================================
  OK: 113 SKIPPED: 2 FAILED: 1
  1. Error: headers returned as expected (@test-response.r#41) 
  
  Error: testthat unit tests failed
  Execution halted
```

## hypothesisr (0.1.0)
Maintainer: Matthew Lincoln <matthew.d.lincoln@gmail.com>  
Bug reports: https://github.com/mdlincoln/hypothesisr/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > 
  > test_check("hypothesisr")
  1. Failure: hs_search returns a list of the expected format. (@test_search.R#21) 
  names(hs_ulysses) not equivalent to c(...).
  Lengths differ: 18 vs 28
  
  
  testthat results ================================================================
  OK: 12 SKIPPED: 1 FAILED: 1
  1. Failure: hs_search returns a list of the expected format. (@test_search.R#21) 
  
  Error: testthat unit tests failed
  Execution halted
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
  running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 20 1 1 50 /var/folders/zt/j4qtgrgx0tj99l6s3lp7833w0000gn/T//RtmpQvcNKM/matrix81575842244.txt /var/folders/zt/j4qtgrgx0tj99l6s3lp7833w0000gn/T//RtmpQvcNKM/coords81535e5daa2.txt' had status 1 
  Execution halted

checking re-building of vignette outputs ... WARNING
Error in re-building vignettes:
  ...
For license and citation information see statnet.org/attribution
or type citation("tergm").

installing MDSJ to directory /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/
trying URL 'http://algo.uni-konstanz.de/software/mdsj/mdsj.jar'
Content type 'application/x-java-archive' length 18203 bytes (17 KB)
==================================================
... 8 lines ...
 USE RESTRICTIONS: Creative Commons License 'by-nc-sa' 3.0.

Calculating layout for network slice from time  75 to 76
No Java runtime present, requesting install.
Warning: running command 'java -cp  /Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java/:/Users/jeroen/workspace/jsonlite/revdep/checks/ndtv.Rcheck/ndtv/java//mdsj.jar MDSJWrapper 16 2 1 50 /var/folders/zt/j4qtgrgx0tj99l6s3lp7833w0000gn/T//RtmpdfPjhz/matrix95233437565.txt /var/folders/zt/j4qtgrgx0tj99l6s3lp7833w0000gn/T//RtmpdfPjhz/coords95211d0542e.txt' had status 1

Error: processing vignette 'ndtv.Rnw' failed with diagnostics:
 chunk 10 (label = calc_params) 
Error in layout.fun(slice, dist.mat = dist.mat, default.dist = default.dist,  : 
  Unable to parse coordinates returned MDSJ java code
Execution halted
```

## trelliscope (0.9.4)
Maintainer: Ryan Hafen <rhafen@gmail.com>  
Bug reports: https://github.com/tesseradata/trelliscope/issues

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘trelliscope-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: cogScagnostics
> ### Title: Compute Scagnostics
> ### Aliases: cogScagnostics
> 
> ### ** Examples
> 
> cogScagnostics(iris$Sepal.Length, iris$Sepal.Width)
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
Warning: running command '/usr/libexec/java_home' had status 1
No Java runtime present, requesting install.

checking dependencies in R code ... NOTE
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
No Java runtime present, requesting install.
```

## webchem (0.1.0.0)
Maintainer: Eduard Szöcs <eduardszoecs@gmail.com>  
Bug reports: https://github.com/ropensci/webchem/issues

1 error  | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘webchem-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: is.smiles
> ### Title: Check if input is a SMILES string
> ### Aliases: is.smiles
> 
> ### ** Examples
> 
> is.smiles('Clc(c(Cl)c(Cl)c1C(=O)O)c(Cl)c1Cl')
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
Warning: running command '/usr/libexec/java_home' had status 1
No Java runtime present, requesting install.
** found \donttest examples: check also with --run-donttest

checking dependencies in R code ... NOTE
Unable to find any JVMs matching version "(null)".
No Java runtime present, try --request to install.
No Java runtime present, requesting install.
```

## x.ent (1.1.2)
Maintainer: Tien T. Phan <phantien84@gmail.com>  
Bug reports: https://github.com/tienpt/x.ent/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘x.ent’ can be installed ... ERROR
Installation failed.
See ‘/Users/jeroen/workspace/jsonlite/revdep/checks/x.ent.Rcheck/00install.out’ for details.
```


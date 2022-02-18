# conos

<details>

* Version: 1.4.5
* GitHub: https://github.com/kharchenkolab/conos
* Source code: https://github.com/cran/conos
* Date/Publication: 2022-01-21 09:12:56 UTC
* Number of recursive dependencies: 239

Run `cloud_details(, "conos")` for more info

</details>

## In both

*   checking whether package ‘conos’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/tmp/workdir/conos/new/conos.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘conos’ ...
** package ‘conos’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
g++ -std=gnu++11 -I"/opt/R/4.1.1/lib/R/include" -DNDEBUG  -I'/opt/R/4.1.1/lib/R/site-library/Rcpp/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppArmadillo/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppEigen/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppProgress/include' -I/usr/local/include  -I"./include" -fopenmp  -fpic  -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/Eigen/Core:397,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/Eigen/Dense:1,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/RcppEigenForward.h:30,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/RcppEigen.h:25,
                 from RcppExports.cpp:6:
...
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in dyn.load(file, DLLpath = DLLpath, ...) : 
  unable to load shared object '/opt/R/4.1.1/lib/R/site-library/leidenAlg/libs/leidenAlg.so':
  /rspm_builder/tmp/tmp.vYZcnqsJUt/igraph/libs/igraph.so: cannot open shared object file: No such file or directory
Calls: <Anonymous> ... namespaceImport -> loadNamespace -> library.dynam -> dyn.load
Execution halted
ERROR: lazy loading failed for package ‘conos’
* removing ‘/tmp/workdir/conos/new/conos.Rcheck/conos’


```
### CRAN

```
* installing *source* package ‘conos’ ...
** package ‘conos’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
g++ -std=gnu++11 -I"/opt/R/4.1.1/lib/R/include" -DNDEBUG  -I'/opt/R/4.1.1/lib/R/site-library/Rcpp/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppArmadillo/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppEigen/include' -I'/opt/R/4.1.1/lib/R/site-library/RcppProgress/include' -I/usr/local/include  -I"./include" -fopenmp  -fpic  -g -O2  -c RcppExports.cpp -o RcppExports.o
In file included from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/Eigen/Core:397,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/Eigen/Dense:1,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/RcppEigenForward.h:30,
                 from /opt/R/4.1.1/lib/R/site-library/RcppEigen/include/RcppEigen.h:25,
                 from RcppExports.cpp:6:
...
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in dyn.load(file, DLLpath = DLLpath, ...) : 
  unable to load shared object '/opt/R/4.1.1/lib/R/site-library/leidenAlg/libs/leidenAlg.so':
  /rspm_builder/tmp/tmp.vYZcnqsJUt/igraph/libs/igraph.so: cannot open shared object file: No such file or directory
Calls: <Anonymous> ... namespaceImport -> loadNamespace -> library.dynam -> dyn.load
Execution halted
ERROR: lazy loading failed for package ‘conos’
* removing ‘/tmp/workdir/conos/old/conos.Rcheck/conos’


```

# contribution

<details>

* Version: 0.2.0
* GitHub: https://github.com/openbiox/contribution
* Source code: https://github.com/cran/contribution
* Date/Publication: 2020-12-03 10:30:02 UTC
* Number of recursive dependencies: 61

Run `cloud_details(, "contribution")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘contribution-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: pull_github
    > ### Title: Pull contributions from GitHub
    > ### Aliases: pull_github
    > 
    > ### ** Examples
    > 
    > pull_github(
    ...
        █
     1. ├─contribution::pull_github(...)
     2. │ └─`%>%`(...)
     3. ├─dplyr::mutate(...)
     4. ├─dplyr:::mutate.data.frame(...)
     5. │ └─dplyr:::mutate_cols(.data, ..., caller_env = caller_env())
     6. │   ├─base::withCallingHandlers(...)
     7. │   └─mask$eval_all_mutate(quo)
     8. └─contribution:::.pull(...)
    Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# lightgbm

<details>

* Version: 3.3.2
* GitHub: https://github.com/Microsoft/LightGBM
* Source code: https://github.com/cran/lightgbm
* Date/Publication: 2022-01-14 13:12:42 UTC
* Number of recursive dependencies: 34

Run `cloud_details(, "lightgbm")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      71. Feature penalties work properly (test_parameters.R:14:3) - lgb.train: Found the following passed through '...': num_leaves, learning_rate, objective, feature_penalty, metric. These will be used, but in future releases of lightgbm, this warning will become an error. Add these to 'params' instead. See ?lgb.train for documentation on how to call this function.
      
      72. Feature penalties work properly (test_parameters.R:14:3) - lgb.train: Found the following passed through '...': num_leaves, learning_rate, objective, feature_penalty, metric. These will be used, but in future releases of lightgbm, this warning will become an error. Add these to 'params' instead. See ?lgb.train for documentation on how to call this function.
      
      73. Feature penalties work properly (test_parameters.R:14:3) - lgb.train: Found the following passed through '...': num_leaves, learning_rate, objective, feature_penalty, metric. These will be used, but in future releases of lightgbm, this warning will become an error. Add these to 'params' instead. See ?lgb.train for documentation on how to call this function.
      
      ══ Failed ══════════════════════════════════════════════════════════════════════
      ── 1. Failure (test_lgb.Booster.R:474:7): Booster$eval() should work on a Datase
      `eval_in_mem` not identical to `eval_from_file`.
      Objects equal but not identical
      
      ══ DONE ════════════════════════════════════════════════════════════════════════
      Error: Test failures
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 82.4Mb
      sub-directories of 1Mb or more:
        libs  81.8Mb
    ```


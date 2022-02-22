# rbioapi

<details>

* Version: 0.7.4
* GitHub: https://github.com/moosa-r/rbioapi
* Source code: https://github.com/cran/rbioapi
* Date/Publication: 2021-06-22 08:00:01 UTC
* Number of recursive dependencies: 57

Run `cloud_details(, "rbioapi")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── Failure (test-api_calls_rba_skeleton.R:13:3): .rba_skeleton works ───────────
      Your object's class is `character`` but `response`` is expected.
      ── Error (test-api_calls_rba_skeleton.R:36:3): .rba_skeleton works ─────────────
      Error: The server returned HTTP Status '403' (Redirection: Forbidden).
      Backtrace:
          ▆
       1. ├─testthat::expect_null(object = .rba_skeleton(input_call = request)) at test-api_calls_rba_skeleton.R:36:2
       2. │ └─testthat::quasi_label(enquo(object), label, arg = "object")
       3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
       4. └─rbioapi:::.rba_skeleton(input_call = request)
       5.   └─rbioapi:::.rba_api_call(...)
      
      [ FAIL 4 | WARN 0 | SKIP 0 | PASS 113 ]
      Error: Test failures
      Execution halted
    ```


context("toJSON auto_unbox")

test_that("auto_unbox with vectors", {
  # Special case - a length-1 atomic vector - should not be unboxed
  expect_that(toJSON(1, auto_unbox=TRUE), equals("[1]"));
  expect_that(toJSON(list(1), auto_unbox=TRUE), equals("[1]"));

  # Test other types
  expect_that(toJSON(as.POSIXct('2015-01-01 03:00:00'), auto_unbox=TRUE), equals('["2015-01-01 03:00:00"]'));
  expect_that(toJSON(as.POSIXlt('2015-01-01 03:00:00'), auto_unbox=TRUE), equals('["2015-01-01 03:00:00"]'));

  expect_that(toJSON(1:3, auto_unbox=TRUE), equals("[1,2,3]"));
  expect_that(toJSON(list(1:3), auto_unbox=TRUE), equals("[[1,2,3]]"));
});

test_that("auto_unbox with matrices", {
  # 1x1 matrices should still be in [[]]
  expect_that(toJSON(matrix(1), auto_unbox=TRUE), equals("[[1]]"));
}

test_that("auto_unbox with data frames", {
  df <- data.frame(x=1:2, y=3:4)

  # 1-row data frames in column format shouldn't be unboxed
  expect_that(toJSON(df[1,], auto_unbox=TRUE, dataframe = 'columns'), equals('{"x":[1],"y":[3]}'));
  expect_that(toJSON(df, auto_unbox=TRUE, dataframe = 'columns'), equals('{"x":[1,2],"y":[3,4]}'));
});

test_that("auto_unbox with lists", {
  expect_that(toJSON(list(x=1, y=3), auto_unbox=TRUE), equals('{"x":1,"y":3}'));
  expect_that(toJSON(list(x=c(1,2), y=c(3,4)), auto_unbox=TRUE), equals('{"x":[1,2],"y":[3,4]}'));
});

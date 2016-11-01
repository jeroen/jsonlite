context("toJSON POSIXt")

objects <- list(
  as.POSIXlt("2013-06-17 22:33:44"),
  as.POSIXct("2013-06-17 22:33:44"),
  as.POSIXlt("2013-06-17 22:33:44", tz="Australia/Darwin"),
  as.POSIXct("2013-06-17 22:33:44", tz="Australia/Darwin")
)

test_that("Encoding POSIXt Objects", {

  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object){
    expect_that(toJSON(object), equals("[\"2013-06-17 22:33:44\"]"));
    expect_that(toJSON(object, POSIXt="string"), equals("[\"2013-06-17 22:33:44\"]"));
    expect_that(toJSON(object, POSIXt="ISO8601"), equals("[\"2013-06-17T22:33:44\"]"));
    expect_that(toJSON(object, POSIXt="sdfsdsdf"), throws_error("one of"));
  }));

  #object 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object){
    expect_that(toJSON(object, POSIXt="epoch"), equals("[1371474224000]"));
    expect_that(toJSON(object, POSIXt="mongo"), equals("[{\"$date\":1371474224000}]"));
  }));

});

test_that("Encoding POSIXt object in a list", {
  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object){
    expect_that(toJSON(list(foo=object)), equals("{\"foo\":[\"2013-06-17 22:33:44\"]}"));
    expect_that(toJSON(list(foo=object), POSIXt="string"), equals("{\"foo\":[\"2013-06-17 22:33:44\"]}"));
    expect_that(toJSON(list(foo=object), POSIXt="ISO8601"), equals("{\"foo\":[\"2013-06-17T22:33:44\"]}"));
    expect_that(toJSON(list(foo=object), POSIXt="sdfsdsdf"), throws_error("one of"));
  }));

  #list(foo=object) 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object){
    expect_that(toJSON(list(foo=object), POSIXt="epoch"), equals("{\"foo\":[1371474224000]}"));
    expect_that(toJSON(list(foo=object), POSIXt="mongo"), equals("{\"foo\":[{\"$date\":1371474224000}]}"));
  }));
});

test_that("Encoding POSIXt object in a list", {
  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object){
    expect_that(toJSON(data.frame(foo=object)), equals("[{\"foo\":\"2013-06-17 22:33:44\"}]"));
    expect_that(toJSON(data.frame(foo=object), POSIXt="string"), equals("[{\"foo\":\"2013-06-17 22:33:44\"}]"));
    expect_that(toJSON(data.frame(foo=object), POSIXt="ISO8601"), equals("[{\"foo\":\"2013-06-17T22:33:44\"}]"));
    expect_that(toJSON(data.frame(foo=object), POSIXt="sdfsdsdf"), throws_error("one of"));
  }));

  #list(foo=object) 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object){
    expect_that(toJSON(data.frame(foo=object), POSIXt="epoch"), equals("[{\"foo\":1371474224000}]"));
    expect_that(toJSON(data.frame(foo=object), POSIXt="mongo"), equals("[{\"foo\":{\"$date\":1371474224000}}]"));
  }));
});

test_that("POSIXt NA values", {
  newobj <- list(
    c(objects[[1]], NA),
    c(objects[[2]], NA)
  );
  lapply(newobj, function(object){
    expect_that(toJSON(object), equals("[\"2013-06-17 22:33:44\",null]"));
    expect_that(toJSON(object, na="string"), equals("[\"2013-06-17 22:33:44\",\"NA\"]"));
    expect_that(toJSON(data.frame(foo=object)), equals("[{\"foo\":\"2013-06-17 22:33:44\"},{}]"));
    expect_that(toJSON(data.frame(foo=object), na="null"), equals("[{\"foo\":\"2013-06-17 22:33:44\"},{\"foo\":null}]"));
    expect_that(toJSON(data.frame(foo=object), na="string"), equals("[{\"foo\":\"2013-06-17 22:33:44\"},{\"foo\":\"NA\"}]"));
  });
});

test_that("Negative dates", {
  x <- objects[[2]]
  y <- x - c(1e9, 2e9, 3e9)
  expect_that(fromJSON(toJSON(y, POSIXt = "mongo")), equals(y))
})


context("fromJSON dataframes")

options(stringsAsFactors=FALSE);

test_that("recover nested data frames", {

  x1 <- x2 <- x3 <- x4 <- x5 <- x6 <- data.frame(foo=c(1:2));
  x2$bar <- c("jeroen", "eli");
  x3$bar <- x4$bar <- x5$bar <- x6$bar <- data.frame(name=c("jeroen", "eli"))
  x4$bar$age <- x5$bar$age <- c(28, 24);  x6$bar$age <- c(28, NA);
  x5$bar$food <- data.frame(yum=c("Rice", "Pasta"));
  x6$bar$food <- data.frame(yum=c(NA, "Pasta"));

  #add to list
  objects <- list(x1, x2, x3, x4, x5, x6)

  #test all but list
  lapply(objects, function(object){
    expect_that(fromJSON(toJSON(object)), equals(object))
    expect_that(fromJSON(toJSON(object, na="null")), equals(object))
    expect_that(names(fromJSON(toJSON(object), flatten = TRUE)), equals(names(unlist(object[1,,drop=FALSE]))))
  });

  #test all in list
  expect_that(fromJSON(toJSON(objects)), equals(objects))
});

test_that("recover lists in data frames", {
  x <- data.frame(author = c("Homer", "Virgil", "Jeroen"));
  x$poems = list(c("Iliad", "Odyssey"), c("Eclogues", "Georgics", "Aeneid"), character());

  y <- data.frame(author = c("Homer", "Virgil", "Jeroen"));
  y$poems = list(
    data.frame(title=c("Iliad", "Odyssey"), year=c(-1194, -800)),
    data.frame(title=c("Eclogues", "Georgics", "Aeneid"), year=c(-44, -29, -19)),
    data.frame()
  );

  z <- list(x=x, y=y);
  zz <- list(x,y);

  expect_that(fromJSON(toJSON(x)), equals(x))
  expect_that(fromJSON(toJSON(y)), equals(y))
  expect_that(fromJSON(toJSON(z)), equals(z))
  expect_that(fromJSON(toJSON(zz)), equals(zz))
});

#note: nested matrix does not perfectly restore
test_that("nested matrix in data frame", {
  x <- data.frame(foo=1:2)
  x$bar <- matrix(c(1:5, NA), 2)

  expect_that(validate(toJSON(x)), is_true())

  y <- fromJSON(toJSON(x))
  expect_that(y, is_a("data.frame"))
  expect_that(names(x), equals(names(y)))
  expect_that(length(y[[1,"bar"]]), equals(3))
});

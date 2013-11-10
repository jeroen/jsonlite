context("fromJSON dataframes")

options(stringsAsFactors=FALSE);

test_that("recover nested data frames", {
    
  objects <- list(
    data.frame(foo=c(1:2)),
    data.frame(foo=c(1:2), bar=c("jeroen", "eli")),
    data.frame(foo=c(1:2), bar=data.frame(name=c("jeroen", "eli"))),
    data.frame(foo=c(1:2), bar=data.frame(name=c("jeroen", "eli"), age=c(28, 24))),
    data.frame(foo=c(1:2), bar=data.frame(name=c("jeroen", "eli"), age=c(28, 24), food=data.frame(yum=c("Rice", "Pasta")))),
    data.frame(foo=c(1:2), bar=data.frame(name=c("jeroen", "eli"), age=c(28, NA), food=data.frame(yum=c(NA, "Pasta"))))
  )
  
  #test all but list
  lapply(objects, function(object){
    expect_that(fromJSON(toJSON(object)), equals(object))   
    expect_that(fromJSON(toJSON(object, na="null")), equals(object))
  });
  
  #test all in list
  expect_that(fromJSON(toJSON(objects)), equals(objects))
});

test_that("recover lists in data frames", {
  x <- data.frame(author = c("Homer", "Virgil", "Jeroen"));
  x$poems = list(c("Iliad", "Odyssey"), c("Eclogues", "Georgics", "Aeneid"), list());
               
  y <- data.frame(author = c("Homer", "Virgil", "Jeroen"));
  y$poems = list(
    data.frame(title=c("Iliad", "Odyssey"), year=c(-1194, -800)),
    data.frame(title=c("Eclogues", "Georgics", "Aeneid"), year=c(-44, -29, -19)),
    list()
  );
  
  z <- list(x=x, y=y);
  zz <- list(x,y);
  
  expect_that(fromJSON(toJSON(x)), equals(x))
  expect_that(fromJSON(toJSON(y)), equals(y))
  expect_that(fromJSON(toJSON(z)), equals(z))
  expect_that(fromJSON(toJSON(zz)), equals(zz))
});

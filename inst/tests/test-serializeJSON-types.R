#test serializeJSON 

context("Serializing Data Types")

# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("Serializing Data Objects", {

  objects <- list(
    NULL,
    readBin(system.file(package="base", "Meta/package.rds"), "raw", 999),
    c(TRUE, FALSE, NA, FALSE),
    c(1L, NA, 9999999),
    c(round(pi, 4), NA, NaN, Inf, -Inf),
    c("foo", NA, "bar"),
    complex(real=1:10, imaginary=1001:1010),
    Reaction ~ Days + (1|Subject) + (0+Days|Subject),
    as.name("cars"),
    as.pairlist(mtcars),
    quote(rnorm(10)),
    expression("to be or not to be"),
    expression(foo),
    parse(text="rnorm(10);"),    
    call("rnorm", n=10),
    emptyenv(),
    `if`, #builtin
    `list`, #special
    getNamespace("graphics") #namespace
  ) 
  
  #test all but list
  lapply(objects, function(object){
    expect_that(unserializeJSON(serializeJSON(object)), equals(object))   
  });
  
  #test all in list
  expect_that(unserializeJSON(serializeJSON(objects)), equals(objects))
});

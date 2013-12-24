context("libjson UTF-8 characters")

test_that("test that non ascii characters are ok", {
  
  #create random strings
  objects <- list(
    "Zürich",
    "北京填鴨们",
    "ผัดไทย",
    "寿司"
  );
  
  lapply(objects, function(x){
    myjson <- toJSON(x);
    expect_that(validate(myjson), is_true());
    expect_that(fromJSON(myjson), equals(x));
  });
});

context("libjson UTF-8 characters")

# Some notes: JSON defines UTF-8 as the default charset. Therefore all encoders and
# decoders are required to support UTF-8. JSON also allows for escaped unicode, i.e 
# \u00F8 however this is mostly for legacy purposes. Using actual UTF-8 characters 
# is easier and more efficient.


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
    
    #prettify needs to parse + output
    prettyjson <- prettify(myjson);
    expect_that(validate(prettyjson), is_true());
    expect_that(fromJSON(prettyjson), equals(x));      
  });
});


#Test unicode escape notation
test_that("escaped unicode gets parsed OK", {
  #disabled until fixed
  #expect_that(fromJSON('["z\\u00FCrich"]'), equals("Zürich"));
  #expect_that(fromJSON('["z\\xFCrich"]'), equals("Zürich"));
  
  #This certainly doesn't work because we need to enable #define JSON_UNICODE but R doesnt support this very well.
  #expect_that(fromJSON('["\\u586B"]'), equals("填"));
});

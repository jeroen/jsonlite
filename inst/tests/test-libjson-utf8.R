context("libjson UTF-8 characters")

# Some notes: JSON defines UTF-8 as the default charset. Therefore all encoders and
# decoders are required to support UTF-8. JSON also allows for escaped unicode, i.e 
# \u00F8 however this is mostly for legacy purposes. Using actual UTF-8 characters 
# is easier and more efficient.


test_that("test that non ascii characters are ok", {
  #only run these tests with UTF8 locale (reported by BR)
  if(grepl("utf|UTF", Sys.getlocale("LC_CTYPE"))) {
    #create random strings
    objects <- list(
      "Zürich",
      "北京填鴨们",
      "ผัดไทย",
      "寿司"
    );
    
    lapply(objects, function(x){
      myjson <- toJSON(x, pretty=TRUE);
      expect_that(validate(myjson), is_true());
      expect_that(fromJSON(myjson, unicode = TRUE), equals(x));
      
      #prettify needs to parse + output
      prettyjson <- prettify(myjson);
      expect_that(validate(prettyjson), is_true());
      expect_that(fromJSON(prettyjson, unicode = TRUE), equals(x));      
    });
    
    #Test escaped unicode characters 
    expect_that(fromJSON('["Z\\u00FCrich"]', unicode = TRUE), equals("Zürich"));
    expect_that(fromJSON(prettify('["Z\\u00FCrich"]'), unicode = TRUE), equals("Zürich"));
    
    expect_that(length(unique(fromJSON('["Z\\u00FCrich", "Zürich"]', unicode = TRUE))), equals(1L))
    expect_that(fromJSON('["\\u586B"]', unicode = TRUE), equals("填"));
    expect_that(fromJSON(prettify('["\\u586B"]'), unicode = TRUE), equals("填"));
  } else {
    cat("skip")
  }
});

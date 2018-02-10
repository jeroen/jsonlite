context("libjson UTF-8 characters")

# Some notes: JSON defines UTF-8 as the default charset. Therefore all encoders and
# decoders are required to support UTF-8. JSON also allows for escaped unicode, i.e
# \u00F8 however this is mostly for legacy purposes. Using actual UTF-8 characters
# is easier and more efficient.


test_that("test that non ascii characters are ok", {

  #create random strings
  objects <- list(
    enc2utf8("Zürich"),
    enc2native("Maëlle"),
    "北京填鴨们",
    "ผัดไทย",
    "寿司",
    c("寿司", "Zürich", "foo", "bla\001\002\003bla"),
    rawToChar(as.raw(1:40))
  )

  lapply(objects, function(x){
    #Encoding(x) <- "UTF-8"
    myjson <- toJSON(x, pretty=TRUE);
    expect_that(validate(myjson), is_true());
    expect_that(fromJSON(myjson), equals(x));

    #prettify needs to parse + output
    prettyjson <- prettify(myjson);
    expect_that(validate(prettyjson), is_true());
    expect_that(fromJSON(prettyjson), equals(x));

    #test encoding is preserved when roundtripping to disk
    tmp <- tempfile()
    write_json(x, tmp)
    expect_that(read_json(tmp, simplifyVector = TRUE), equals(x));
    unlink(tmp)
  });

  #Test escaped unicode characters
  expect_that(fromJSON('["Z\\u00FCrich"]'), equals("Z\u00fcrich"));
  expect_that(fromJSON(prettify('["Z\\u00FCrich"]')), equals("Z\u00fcrich"));

  expect_that(length(unique(fromJSON('["Z\\u00FCrich", "Z\u00fcrich"]'))), equals(1L))
  expect_that(fromJSON('["\\u586B"]'), equals("\u586b"));
  expect_that(fromJSON(prettify('["\\u586B"]')), equals("\u586B"));

});

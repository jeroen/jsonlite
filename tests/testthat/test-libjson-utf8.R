context("libjson UTF-8 characters")

# Some notes: JSON defines UTF-8 as the default charset. Therefore all encoders and
# decoders are required to support UTF-8. JSON also allows for escaped unicode, i.e
# \u00F8 however this is mostly for legacy purposes. Using actual UTF-8 characters
# is easier and more efficient.


test_that("test that non ascii characters are ok", {

  #create random strings
  objects <- list(
    enc2utf8("Z\u00fcrich"),
    enc2native("Ma\u00eblle"),
    "\u5317\u4eac\u586b\u9d28\u4eec",
    "\u0e1c\u0e31\u0e14\u0e44\u0e17",
    "\u5bff\u53f8",
    c("\u5bff\u53f8", "Z\\u00fcrich", "foo", "bla\001\002\003bla"),
    rawToChar(as.raw(1:40))
  )

  lapply(objects, function(x){
    #Encoding(x) <- "UTF-8"
    myjson <- toJSON(x, pretty=TRUE);
    expect_true(validate(myjson));
    expect_equal(fromJSON(myjson), x);

    #prettify needs to parse + output
    prettyjson <- prettify(myjson);
    expect_true(validate(prettyjson));
    expect_equal(fromJSON(prettyjson), x);

    #test encoding is preserved when roundtripping to disk
    tmp <- tempfile()
    write_json(x, tmp)
    expect_equal(read_json(tmp, simplifyVector = TRUE), x);
    unlink(tmp)
  });

  #Test escaped unicode characters
  expect_equal(fromJSON('["Z\\u00FCrich"]'), "Z\u00fcrich");
  expect_equal(fromJSON(prettify('["Z\\u00FCrich"]')), "Z\u00fcrich");

  expect_equal(length(unique(fromJSON('["Z\\u00FCrich", "Z\u00fcrich"]'))), 1L);
  expect_equal(fromJSON('["\\u586B"]'), "\u586b");
  expect_equal(fromJSON(prettify('["\\u586B"]')), "\u586B");

});

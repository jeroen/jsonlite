setGeneric("asJSON", function(x, ...) {
  standardGeneric("asJSON")
})

if(getRversion() < 4){
  setOldClass("AsIs")
  setOldClass(c("blob", "vctrs_list_of", "vctrs_vctr"))
  setOldClass("integer64")
  setOldClass(c("hms", "difftime"))
  setOldClass("ITime")
  setOldClass("json")
  setOldClass("pairlist")
  setOldClass("scalar")
  setOldClass("sf")
  setOldClass("sfc")
}

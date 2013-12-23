library(jsonlite)

#these should all return TRUE
validate('["\\""]');
validate('["\\"#"]');
validate('["\\"/" ]');
validate('["\\" " ]');


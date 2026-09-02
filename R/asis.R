# Minimal local replacement for R.rsp::asis, used only to include the
# prebuilt json-mapping.pdf vignette. The pdf sits next to the .asis file
# at build time, but when checking a tarball it is only in inst/doc, so
# copy it back from there. There is no R code to tangle.
.onLoad <- function(libname, pkgname) {
  tools::vignetteEngine(
    'asis',
    weave = function(file, ...) {
      out <- sub("\\.asis$", "", basename(file))
      if (!file.exists(out)) {
        file.copy(file.path(dirname(file), '..', 'inst', 'doc', out), out)
      }
      out
    },
    tangle = function(file, ...) character(0),
    pattern = "\\.pdf\\.asis$",
    package = pkgname
  )
}

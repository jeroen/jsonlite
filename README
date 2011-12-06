This RJSONIO package uses the libjson C library from
libjson.sourceforge.net.  A version of that C++ code is included in
this package and can be used.  Alternatively, one can use a different
version of libjson, e.g. a more recent version.  To do this,
you install that version of libjson with

     make SHARED=1 install

The key thing is to make this a shared library so we can link against
it as position independent code (PIC).

By default, this will be installed in /usr/local.
You can control this with

     make SHARED=1 install prefix="/my/directory"


The configuration script will attempt to find libjson on your system,
looking in /usr/local. If this is not the location you installed
libjson to, you can specify the prefix via the --with-prefix=/my/directory,
e.g. 
   R CMD INSTALL --configure-args="--with-prefix=/my/directory" RJSONIO

If you want to force using the version of libjson contained in this package,
you can use

   R CMD INSTALL --configure-args="--with-local-libjson=yes" RJSONIO


If you do use a version of libjson installed into a non-standard place,
you will probably need to modify your LD_LIBRARY_PATH (or DYLD_LIBRARY_PATH on OS X)
environment variable.


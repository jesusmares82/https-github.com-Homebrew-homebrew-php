require File.join(File.dirname(__FILE__), 'abstract-php')

class Php53 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.3.28.tar.bz2/from/this/mirror'
  sha1 'f985ca1f6a5f49ebfb25a08f1837a44c563b31f8'
  version '5.3.28'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.3'

  depends_on 'libevent' if build.include? 'with-fpm'

  def install_args
    super + [
      "--enable-zend-multibyte",
      "--enable-sqlite-utf8",
    ]
  end

  def php_version
    5.3
  end

  def php_version_path
    53
  end

  def patches
    DATA
  end
end

__END__
diff --git a/configure b/configure
index d506892..51617e8 100755
--- a/configure
+++ b/configure
@@ -38277,7 +38277,7 @@ fi
   if test "$PHP_FREETYPE_DIR" != "no"; then

     for i in $PHP_FREETYPE_DIR /usr/local /usr; do
-      if test -f "$i/include/freetype2/freetype/freetype.h"; then
+      if test -f "$i/include/freetype2/freetype.h"; then
         FREETYPE2_DIR=$i
         FREETYPE2_INC_DIR=$i/include/freetype2
         break
@@ -107971,7 +107971,7 @@
 LDFLAGS="$LDFLAGS $PHP_AIX_LDFLAGS"

 case $host_alias in
-*darwin9*|*darwin10*|*darwin11*|*darwin12*)
+*darwin9*|*darwin10*|*darwin11*|*darwin12*|*darwin13*)
   ac_cv_exeext=
   ;;
 esac
diff --git a/configure.in b/configure.in
index 4bf50ad..b0c9747 100644
--- a/configure.in
+++ b/configure.in
@@ -1338,7 +1338,7 @@ LDFLAGS="$LDFLAGS $PHP_AIX_LDFLAGS"
 dnl Autoconf 2.13's libtool checks go slightly nuts on Mac OS X 10.5, 10.6, 10.7 and 10.8.
 dnl This hack works around it. Ugly.
 case $host_alias in
-*darwin9*|*darwin10*|*darwin11*|*darwin12*)
+*darwin9*|*darwin10*|*darwin11*|*darwin12*|*darwin13*)
   ac_cv_exeext=
   ;;
 esac

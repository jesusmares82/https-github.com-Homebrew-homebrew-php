require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php53 < AbstractPhp
  init
  include AbstractPhpVersion::Php53Defs

  url     PHP_SRC_TARBALL
  sha256  PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head    PHP_GITHUB_URL, :branch => PHP_BRANCH

  # build dependancy needed to fix issue #962
  depends_on 'autoconf' => :build
  depends_on 're2c' => :build
  depends_on 'flex' => :build
  depends_on 'homebrew/versions/bison27' => :build

  depends_on 'libevent' if build.with? 'fpm'

  if build.with? 'phpdbg'
    raise "phpdbg is not supported for this version of PHP"
  end

  def install
    # files need to be regenerated to fix issue #962
    system "rm Zend/zend_{language,ini}_parser.[ch]"
    super()
  end

  def install_args
    args = super
    args << "--enable-zend-multibyte" unless build.include? 'disable-zend-multibyte'
    args << "--enable-sqlite-utf8"
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
+*darwin9*|*darwin10*|*darwin11*|*darwin12*|*darwin13*|*darwin14*)
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
+*darwin9*|*darwin10*|*darwin11*|*darwin12*|*darwin13*|*darwin14*)
   ac_cv_exeext=
   ;;
 esac
diff --git a/Zend/zend_language_parser.y b/Zend/zend_language_parser.y
index d24fc9c..4314efb 100644
--- a/Zend/zend_language_parser.y
+++ b/Zend/zend_language_parser.y
@@ -38,10 +38,6 @@

 #define YYERROR_VERBOSE
 #define YYSTYPE znode
-#ifdef ZTS
-# define YYPARSE_PARAM tsrm_ls
-# define YYLEX_PARAM tsrm_ls
-#endif


 %}
@@ -49,6 +45,13 @@
 %pure_parser
 %expect 2

+%code requires {
+#ifdef ZTS
+# define YYPARSE_PARAM tsrm_ls
+# define YYLEX_PARAM tsrm_ls
+#endif
+}
+
 %left T_INCLUDE T_INCLUDE_ONCE T_EVAL T_REQUIRE T_REQUIRE_ONCE
 %left ','
 %left T_LOGICAL_OR
diff --git a/configure b/configure
--- a/configure
+++ b/configure
@@ -3019,12 +3019,7 @@
       if test -n "$bison_version_vars"; then
         set $bison_version_vars
         bison_version="${1}.${2}"
-        for bison_check_version in $bison_version_list; do
-          if test "$bison_version" = "$bison_check_version"; then
-            php_cv_bison_version="$bison_check_version (ok)"
-            break
-          fi
-        done
+        php_cv_bison_version="$bison_version (ok)"
       fi
     
 fi
diff --git a/Zend/acinclude.m4 b/Zend/acinclude.m4
index 77430ab..5aeed94 100644
--- a/Zend/acinclude.m4
+++ b/Zend/acinclude.m4
@@ -17,12 +17,7 @@ AC_DEFUN([LIBZEND_BISON_CHECK],[
       if test -n "$bison_version_vars"; then
         set $bison_version_vars
         bison_version="${1}.${2}"
-        for bison_check_version in $bison_version_list; do
-          if test "$bison_version" = "$bison_check_version"; then
-            php_cv_bison_version="$bison_check_version (ok)"
-            break
-          fi
-        done
+        php_cv_bison_version="$bison_version (ok)"
       fi
     ])
   fi

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Wbxml < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/wbxml'
  url 'http://pecl.php.net/get/wbxml-1.0.3.tgz'
  sha1 '2cf4705ad135a9695b3fc8e5e7135f6ad89623e6'
  head 'https://svn.php.net/repository/pecl/wbxml/trunk/'

  depends_on 'libwbxml'

  def patches
    # php-wbxml looks for the libwbxml headers in the wrong location
    DATA
  end

  def install
    Dir.chdir "wbxml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-wbxml=#{Formula['libwbxml'].opt_prefix}"
    system "make"
    prefix.install "modules/wbxml.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff -rBNu wbxml-1.0.3/wbxml-1.0.3/config.m4 wbxml-patched/wbxml-1.0.3/config.m4
--- wbxml-1.0.3/wbxml-1.0.3/config.m4 2009-02-22 03:30:57.000000000 -0800
+++ wbxml-patched/wbxml-1.0.3/config.m4 2013-01-26 03:55:21.000000000 -0800
@@ -43,7 +43,7 @@
   ],-L$WBXML_LIBDIR)

   PHP_ADD_LIBRARY_WITH_PATH(wbxml2, $WBXML_LIBDIR, WBXML_SHARED_LIBADD)
-  PHP_ADD_INCLUDE($WBXML_DIR/include)
+  PHP_ADD_INCLUDE($WBXML_DIR/include/libwbxml-1.0/wbxml)

   for i in $PHP_LIBEXPAT_DIR /usr/local /usr; do
     for j in $PHP_LIBDIR lib64 lib; do

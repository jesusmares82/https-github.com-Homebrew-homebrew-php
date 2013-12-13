require File.join(File.dirname(__FILE__), 'abstract-php')

class Php55 < AbstractPhp
  init
  url 'http://www.php.net/get/php-5.5.7.tar.bz2/from/this/mirror'
  sha1 'f32ccf1a2aa0592e2dcc151c89a7a811e53e0925'
  version '5.5.7'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.5'

  # Leopard requires Hombrew OpenSSL to build correctly
  depends_on 'openssl' if MacOS.version == :leopard

  def install_args
    args = super
    args << "--with-homebrew-openssl" if MacOS.version == :leopard
    args + [
      "--enable-zend-signals",
      "--enable-dtrace",
      "--enable-opcache",
    ]
  end

  def php_version
    5.5
  end

  def php_version_path
    55
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

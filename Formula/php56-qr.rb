require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Qr < AbstractPhp56Extension
  init
  desc "QR Code generator extension."
  homepage "http://pecl.opendogs.org/"
  url "http://pecl.opendogs.org/get/qr-0.4.0.tgz"
  sha256 "0d628741d77f34207a00cc0b84967ecf4ccb38f03e65105573ecfead8c76f114"

  bottle do
    rebuild 4
    sha256 "1959a83d910fdc9e265d0da30f5ff8fe03d4ce9725fc0fdbf24967d854b0477a" => :el_capitan
    sha256 "e35a67138b99145aca0e60826f99bdcda0da655cb32fd19350051791d07a632f" => :yosemite
    sha256 "849c428e340e9053dd0aed14f193154369335710546910916181caf9aa336ff1" => :mavericks
  end

  depends_on "homebrew/dupes/zlib"

  patch :DATA

  def install
    Dir.chdir "qr-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--enable-qr", "--enable-qr-gd", "--with-qr-tiff=#{HOMEBREW_PREFIX}/opt/zlib"
    phpconfig
    system "make"
    prefix.install "modules/qr.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
--- qr-0.4.0/qr-0.4.0/php_qr.c-org	2014-11-16 00:59:40.000000000 +0900
+++ qr-0.4.0/qr-0.4.0/php_qr.c	2014-11-16 01:01:26.000000000 +0900
@@ -31,7 +31,9 @@
 #include <Zend/zend_exceptions.h>
 #include "qr.h"
 #include "qr_util.h"
-#include <main/php_logos.h>
+#if PHP_VERSION_ID < 50500
+#  include <main/php_logos.h>
+#endif
 #include "qr_logos.h"

 #if PHP_QR_USE_GD_WRAPPERS
@@ -892,7 +894,9 @@
 	_qr_wrappers_init(INIT_FUNC_ARGS_PASSTHRU);
 #endif
 	REGISTER_INI_ENTRIES();
+#if PHP_VERSION_ID < 50500
 	php_register_info_logo(QR_LOGO_GUID, QR_LOGO_TYPE, qr_logo, QR_LOGO_SIZE);
+#endif

 	QR_REGISTER_CONSTANT(QR_EM_AUTO);
 	QR_REGISTER_CONSTANT(QR_EM_NUMERIC);
@@ -1036,7 +1040,9 @@
 PHP_MSHUTDOWN_FUNCTION(qr)
 {
 	UNREGISTER_INI_ENTRIES();
+#if PHP_VERSION_ID < 50500
 	php_unregister_info_logo(QR_LOGO_GUID);
+#endif

 	return SUCCESS;
 }





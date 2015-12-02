require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.1.2.tgz"
  sha256 "528769ac304a0bbe9a248811325042188c9d16e06de16f111fee317c85a36c93"
  head "https://svn.php.net/repository/pecl/imagick/trunk/"
  revision 1

  bottle do
    revision 2
    sha256 "03f003ed9506efd749ef3b0b41f0374f5f63d989d93de8c1cb557b0b44ebd425" => :el_capitan
    sha256 "595b71f135e0991a50be4217e3385c5d7ae445cc777b73e2d9904ad7a57f0404" => :yosemite
    sha256 "f6e6e29c112dcd6d02d800fb53dcd6190dba2127ceb6e1bd4fc5a645b5de507d" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  # Rationale: Fix for the header file MagickWand.h
  #     could not be located error during ./configure
  #
  # Original error message:
  #     checking for MagickWand.h header file...
  #     configure: error: Cannot locate header file MagickWand.h
  patch :DATA

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff --git a/imagick-3.1.0RC2/config.m4 b/imagick-3.1.0RC2/config.m4
index 6caa29a..1c6cdfb 100644
--- a/imagick-3.1.2/config.m4
+++ b/imagick-3.1.2/config.m4
@@ -60,6 +60,8 @@ if test $PHP_IMAGICK != "no"; then
 
     if test -r $WAND_DIR/include/ImageMagick/wand/MagickWand.h; then
       AC_MSG_RESULT(found in $WAND_DIR/include/ImageMagick/wand/MagickWand.h)
+    elif test -r $WAND_DIR/include/ImageMagick-6/wand/MagickWand.h; then
+      AC_MSG_RESULT(found in $WAND_DIR/include/ImageMagick-6/wand/MagickWand.h)
     else
       AC_MSG_ERROR(Cannot locate header file MagickWand.h)
     fi

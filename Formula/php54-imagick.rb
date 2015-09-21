require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.1.2.tgz"
  sha1 "7cee88bc8f6f178165c9d43e302d99cedfbb3dff"
  head "https://svn.php.net/repository/pecl/imagick/trunk/"
  revision 1

  bottle do
    sha256 "7098323019d86ef8d250ffb7a3d46db6c24e5d9305f287f09fccf23038a2e412" => :yosemite
    sha256 "ce33ba00d36518ab2efcdcd9111b10eec85649d21e767eda6597fa3c8d55c4df" => :mavericks
    sha256 "03153e7e4c8dd46d3ad38c567f188c509cbd678b87dd52ff9a73c5da62222a80" => :mountain_lion
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

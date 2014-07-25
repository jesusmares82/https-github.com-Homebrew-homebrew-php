require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/imagick'
  url 'http://pecl.php.net/get/imagick-3.1.0RC2.tgz'
  sha1 '29b6dcd534cde6b37ebe3ee5077b71a9eed685c2'
  head 'https://svn.php.net/repository/pecl/imagick/trunk/'

  depends_on 'pkg-config' => :build
  depends_on 'imagemagick'

  def patches
    # Rationale: Fix for the header file MagickWand.h
    #     could not be located error during ./configure
    #
    # Original error message:
    #     checking for MagickWand.h header file...
    #     configure: error: Cannot locate header file MagickWand.h
    DATA
  end

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff --git a/imagick-3.1.0RC2/config.m4 b/imagick-3.1.0RC2/config.m4
index 6caa29a..1c6cdfb 100644
--- a/imagick-3.1.0RC2/config.m4
+++ b/imagick-3.1.0RC2/config.m4
@@ -54,6 +54,8 @@ if test $PHP_IMAGICK != "no"; then
 
     if test -r $WAND_DIR/include/ImageMagick/wand/MagickWand.h; then
       AC_MSG_RESULT(found in $WAND_DIR/include/ImageMagick/wand/MagickWand.h)
+    elif test -r $WAND_DIR/include/ImageMagick-6/wand/MagickWand.h; then
+      AC_MSG_RESULT(found in $WAND_DIR/include/ImageMagick-6/wand/MagickWand.h)
     else
       AC_MSG_ERROR(Cannot locate header file MagickWand.h)
     fi

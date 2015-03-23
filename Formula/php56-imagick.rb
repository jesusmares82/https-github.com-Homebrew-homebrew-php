require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/imagick'
  url 'http://pecl.php.net/get/imagick-3.1.2.tgz'
  sha1 '7cee88bc8f6f178165c9d43e302d99cedfbb3dff'
  head 'https://svn.php.net/repository/pecl/imagick/trunk/'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "6b38f5a3151b2eb629b538760cbf6f28d5708c080cab225d0f27772f76c9efb8" => :yosemite
    sha256 "9fdf5b27051a8b7044a61cfb4ad5a0b4a1d52e48a17179cfd4ae28e53dd1071c" => :mavericks
    sha256 "edc00b10a168e66fc0e2fe99a75ffac9f072463d492de49fc36115a39c3d9681" => :mountain_lion
  end

  depends_on 'pkg-config' => :build
  depends_on 'imagemagick'

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
                          phpconfig,
                          "--with-imagick=#{Formula['imagemagick'].opt_prefix}"
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

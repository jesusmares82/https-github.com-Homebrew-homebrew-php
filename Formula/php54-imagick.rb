require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/imagick'
  url 'http://pecl.php.net/get/imagick-3.1.2.tgz'
  sha1 '7cee88bc8f6f178165c9d43e302d99cedfbb3dff'
  head 'https://svn.php.net/repository/pecl/imagick/trunk/'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "71d1b1dfb2626460586e93a0d051e4c6403841910174c03f23e5e731b78e4b07" => :yosemite
    sha256 "e88d60a209a24df71e61e5f386f2334b31648417070e100800518da5dbd2a2f8" => :mavericks
    sha256 "0cb9834b29880a85fda4c26f9f25be0eea895eee5dd4e35f33795919a9fe11de" => :mountain_lion
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
                          "--with-imagick=#{Formula['imagemagick'].opt_prefix}",
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

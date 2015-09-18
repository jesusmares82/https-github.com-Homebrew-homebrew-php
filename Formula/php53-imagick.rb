require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  homepage 'https://pecl.php.net/package/imagick'
  url 'https://pecl.php.net/get/imagick-3.1.2.tgz'
  sha256 '528769ac304a0bbe9a248811325042188c9d16e06de16f111fee317c85a36c93'
  head 'https://svn.php.net/repository/pecl/imagick/trunk/'
  revision 1

  bottle do
    revision 1
    sha256 "30d0c4b74f18b83c55114996e08dfc267d18f6169a8ebc352b036874c4be9aad" => :el_capitan
    sha256 "0637d7b6f9d968fee6e78a3b26ea8cb0722dc370e32bb0084f2779815a6718f9" => :yosemite
    sha256 "3ea3573c64ac0ae880f55d11d391be979fd3d29482774c4b04b5e6898049a1a5" => :mavericks
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

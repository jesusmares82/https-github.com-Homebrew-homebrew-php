require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3.tgz"
  sha256 "1f3c5b5eeaa02800ad22f506cd100e8889a66b2ec937e192eaaa30d74562567c"
  head "https://github.com/mkoppanen/imagick.git"
  revision 5

  bottle do
    sha256 "b0f41043357d6d920989ed94f2dc520b4d67a9eefa9daed74724c9dfdbfb6297" => :sierra
    sha256 "984dcda8a52a46bb1e62cbdffc94c8134f36d66bb49e49d99c08ffe1c6027d9d" => :el_capitan
    sha256 "df4f3a043cefc682b680ee85fbbd51fd6a3568752269bab28278248c24169b58" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end

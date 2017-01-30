require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.2.tgz"
  sha256 "8e16b7bc6cf6567f4b4c4ac7294cbf650fe050a848c6a7ba6e2bee02097ab4a8"
  head "https://github.com/mkoppanen/imagick.git"
  revision 7

  bottle do
    sha256 "18210c32543631b4fcc66a26fe44cc02fc98847d224b6f31a396021aa6d82623" => :sierra
    sha256 "49eb056372318d3c19d1d697973e65978d348f41c2a9b071eafa8500dd451c89" => :el_capitan
    sha256 "9b49af133c8fca227dccd438388552073f1549148e2814aa56ece786b4e89c30" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end

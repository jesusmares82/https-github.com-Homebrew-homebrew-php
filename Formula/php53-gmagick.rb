require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gmagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    sha256 "596bdc0782cc04c56238e02ad0ead4d3934e76ab3d9a4e5cae7564cf5d75d424" => :el_capitan
    sha256 "e0e8fcf342d73485b74105ae7730d95053262b350ee589b1025cc0a830a48386" => :yosemite
    sha256 "a11704a1ecee639b5cc7cd91c689e26a1fc43558bdbb8be978bd4937b37b09ac" => :mavericks
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula["graphicsmagick"].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end

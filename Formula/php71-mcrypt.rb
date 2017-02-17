require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 9

  bottle do
    sha256 "7c86e14df5ff0c9f152fff6c9fea00788e4bfac16d8f31814d19df7814f5fe03" => :sierra
    sha256 "edbac83755f1d3789048f96a454c981ea9abb7278161cb7f43e3456473593daf" => :el_capitan
    sha256 "022c163a6b9e5db2c7150298f76f5c4cc6f514be1ecd35894e976bf9b84ebcc0" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end

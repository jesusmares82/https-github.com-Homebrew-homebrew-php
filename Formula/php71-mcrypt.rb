require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 16

  bottle do
    sha256 "136c8b2c899e5e7a16d5060c7ed9fcfd4f0ef5c0fdff294ed86ca905012c4353" => :sierra
    sha256 "e0dfcf91e9ad6f2031bb549740fd6804b8c3101f93d9b32db33054dfc5ef1674" => :el_capitan
    sha256 "6bed0760f9ee8bc48eb661adc59317bc287e134e6e46d3dfdc3f7d67ebc9332d" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

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

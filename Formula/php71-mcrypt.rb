require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 15

  bottle do
    sha256 "93805dd532d5d55a839a35c32c56836496298e54f097caafaf24a88718a14c00" => :sierra
    sha256 "62f19416a4b0e3c4b74a9d160ac22cbbdd8872bcad24234bb55fcdefddf6a248" => :el_capitan
    sha256 "d7668bfc2a4917494abafba374ffb73a60960d57c79ece937ca3dff70b9cf4f2" => :yosemite
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

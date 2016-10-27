require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "2f09cd8bf6ec6e8353ca37ebc1bbb94b6febc88e1bb388ee821d5f8de5e3eaf1" => :sierra
    sha256 "4baf1e98609596eabe98fd67d650d83a8c511037aa0e4e8b930158cc656f0160" => :el_capitan
    sha256 "06bdbca9dead57449d114e322e39ee220b521e943379bc138bcda4b2e4a277f8" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  depends_on "mcrypt"
  depends_on "libtool" => :build

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

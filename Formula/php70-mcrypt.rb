require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 7

  bottle do
    sha256 "fea5dd5ae80c506cd76c348d656c31108290aea86681a4d037b1913396ae9dfd" => :sierra
    sha256 "955fd4290e34d35be75f67fc6ee35eac170698ee7af59627f77ea309fad29f13" => :el_capitan
    sha256 "b87909031a92ce7e4f46ee09cd9fa6fb631eea325ac6c31719b2ae27ef920818" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"

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

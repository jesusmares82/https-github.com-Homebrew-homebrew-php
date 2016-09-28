require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "7ee9c54aa7bcb2b32deaa61b7064a30b9979629063e887eb9afa74be3463bcf2" => :sierra
    sha256 "e6f6a7894b599d36e0935db3aee8d9661172a11cfef00f67a36f5c289221bc4a" => :el_capitan
    sha256 "a9497f242768d8adc79fec53464dbdfcee2c72ca6124e307460dd0053b6875fc" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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

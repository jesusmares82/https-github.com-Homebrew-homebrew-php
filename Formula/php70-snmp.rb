require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 9
    sha256 "f418bbdf93585b7f10184b7bbb968d774e2384bcdc7e06bac07f4fdf7c932ac3" => :el_capitan
    sha256 "1085e683e61d6bd33fda48e39d457ff11c0f5bb14175af52a0cade0b598b5c6d" => :yosemite
    sha256 "385c4022f4fd9c1c0c4097d4176812d15e34809bf98f56e493bd9433d83a7540" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-snmp=#{Formula["net-snmp"].opt_prefix}"
    system "make"
    prefix.install "modules/snmp.so"
    write_config_file if build.with? "config-file"
  end
end


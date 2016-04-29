require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "5d8ab06e702e366df56b52a6f9192275f2054083fd68049fb3da72802f90f6f9" => :el_capitan
    sha256 "178888b63fb566b678daca54ef7fcfe2a51460efcb982f71edbd815246902b3e" => :yosemite
    sha256 "c5d879a0166f195e04fe5e3a4b78fe404c2906a1e06b0c3bf13195b08ed370b6" => :mavericks
  end

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






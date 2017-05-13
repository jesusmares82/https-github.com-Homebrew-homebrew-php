require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 11

  bottle do
    sha256 "9cd94d2e7af0fef26b4cdfadb990b67fa2f8b28b17276dee735e8b0708bf3323" => :sierra
    sha256 "7b6a3edf083cd6da89de77da159cc1bb9f699cd0d100621dd44d5cc2a32ed7e5" => :el_capitan
    sha256 "a20c472930b091344583957f343420c39c42c93087f6be70096d7b7b9809eb26" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

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

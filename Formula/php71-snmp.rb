require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 5

  bottle do
    sha256 "4a628b13bd1c57b27e0ff6903e6664f1b8414bd557ced7bb20b0b3b8b1125dd9" => :sierra
    sha256 "111c18660cab780520e24859e51560fb6bcc2413f41fa09a1e6de00e9e2e69d6" => :el_capitan
    sha256 "55939de76184f25cfe4120a53eac1c580a5f1dbedf03a08a0b25fa19cc093300" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "f3c4654919c6fe6baf8e9345700e2defb17e9d6833e93a9cc124329829d4a3cd" => :sierra
    sha256 "c919f578bed23c0c76fef60b5d977d63bc9fa0a654633f178cef1e8557eb883a" => :el_capitan
    sha256 "0add3d9e09212010781beda9a875104db09e51172b8eb29b71ed0db65defca81" => :yosemite
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

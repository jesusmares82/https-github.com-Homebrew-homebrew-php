require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "548a1cc2f19e493e7aa2de5c1cd5a595366762d730c5d4abf08eca467c4f14ca" => :sierra
    sha256 "12d798a09ac8fa0c1ed9129ce5b3eeec363abbf46a58e89335750c73a08f4cfe" => :el_capitan
    sha256 "09b8673f6418d1098607011649ebb5fc9d897403cfeaeda885e507390fb8c513" => :yosemite
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

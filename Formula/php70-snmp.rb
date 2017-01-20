require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "1616359116e2d2e4b636a81740bb39b45d95c15eab3131d6a45c122cad1ef220" => :sierra
    sha256 "78e1e993a0359f82b9159658ceb82fd7f25bbaa631b94a8772f1d5359c450566" => :el_capitan
    sha256 "3793bf6a6e39c2eb3e098e8fe96402147e7ec0c916ecd9f5b6489af5bd288746" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 10

  bottle do
    sha256 "c67a589dd9959ac0285e6a1b48b3b5320f31f9fb53c7a2aaaff67e1638798b74" => :high_sierra
    sha256 "7d7af81f12341c246aadd919595da7b7358eabd68e786a7ebad3fdf239f5b028" => :sierra
    sha256 "e484725b8c3219b64deb4522847568966bf30f2ab7b815efef54d93f1e10ad41" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

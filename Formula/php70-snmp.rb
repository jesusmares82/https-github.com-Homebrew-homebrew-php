require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 14
    sha256 "75cd0f9de0b09e1219478a78c595a4de395d9caca72bb964b58962ef7f423a88" => :el_capitan
    sha256 "f0da9ce5cbe59975bbacb8d3cb5f130c27bb19bfbe69269109710706ccd7e51e" => :yosemite
    sha256 "23c1adc8b820065c1e709d5a4eceaac9a483e04468e28527c721c3becf665f02" => :mavericks
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








require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "8ee59b180faf5419d0c07c58f22b0d4ce26e874f445ac18242c6e34af1a2dfdb" => :sierra
    sha256 "8927d93b924208b99e7c02b187e215a3fb10c7b5830dcb2c755222d48155334c" => :el_capitan
    sha256 "24cd6c13ee68a50a265de5be157e0a3c4821274ec08428dd80b4c2aec35da806" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 5

  bottle do
    sha256 "0b3b5c4e6e0d2ba74370d5abe64cb479f3fc8ac6131f3a2e7bce5fbdb67a10f8" => :sierra
    sha256 "df37515ea869fdcc65b671879a2bd854f4017232b1285ffc1f903674ce2b13fe" => :el_capitan
    sha256 "636b65cf1ccf59d3fbab4fe2239e7c6363d31977e7395373bdbc627ca5aef222" => :yosemite
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

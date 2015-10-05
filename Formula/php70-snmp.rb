require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 3
    sha256 "220048287a083dc802aa081209e42bf1d60883ea583a57e467c0ad82b20b6ad6" => :el_capitan
    sha256 "1b2fa138bd80788d636ee983c69c6b96b969e045457639b89519684071754e0a" => :yosemite
    sha256 "9115838c7e0df6f9d2a0b349a4c890aa16f920225cd8802cf9632ba1f8a9c236" => :mavericks
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

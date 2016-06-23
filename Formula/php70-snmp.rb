require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 15
    sha256 "00c5b0381fff5b575b812fd36587f8ed3720dcdf9ffd4830a6dc842a278e8de8" => :el_capitan
    sha256 "5b7cab7ff69a21c450969f132576dad16cc56b37103b2610b34827e2ffe70776" => :yosemite
    sha256 "41f55830aa32063d81d1377be50d78fd37959ed1b48e16d781b8d79b5f46fc7d" => :mavericks
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









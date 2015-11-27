require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 7
    sha256 "594bffc4bcc89e88c3f36383bac8c3c66065357a1777e5cc292f50961421c3fc" => :el_capitan
    sha256 "7544b0e0f8d30c93daf904c5fb8ceeb8499e550506abe58e70b1280dcf4dbc73" => :yosemite
    sha256 "789fbdcf2b2719c1422989f286aacbade0c55a07f14d5c79bdab3f2b1d61642a" => :mavericks
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

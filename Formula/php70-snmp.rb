require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 14

  bottle do
    sha256 "369fa2351976647e28587687b2bb728f4514bc7459a08a6dd4a03002e1c163aa" => :high_sierra
    sha256 "423ea76eb515824cdf0619f5d948d923996076815352992b6b279dcc3d5b7f77" => :sierra
    sha256 "396f36345ebfb1b33182bd92b8a22bd469dd5cb45142c04c828b0b46596a71d7" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

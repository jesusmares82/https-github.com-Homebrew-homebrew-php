require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 11

  bottle do
    sha256 "60e56c03562a3689ee8bde16b95440bda48b03c7d92c8b8e387a8d84e9d103de" => :sierra
    sha256 "02017d0838c8091ef56bc7eff8f9ca2dfedb3ffaad1009edcf83b02694e06797" => :el_capitan
    sha256 "44630b13fdecad841ef6abec297087050f96c5dd797fc210ec886720a594d5f3" => :yosemite
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

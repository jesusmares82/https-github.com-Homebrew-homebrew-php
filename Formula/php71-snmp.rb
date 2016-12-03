require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 6

  bottle do
    sha256 "c0e6befcdfd9738735611edfaf7eb6cc6e0842d41d57d61b671ad70783218f6d" => :sierra
    sha256 "5e5c93960393a840073fa7e3e44b4476111d236703a708f600df821603a7a31e" => :el_capitan
    sha256 "4846385c11e0e2180525ae95b4f93bdaf728c68f734fd8c3559de395a1e084b2" => :yosemite
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

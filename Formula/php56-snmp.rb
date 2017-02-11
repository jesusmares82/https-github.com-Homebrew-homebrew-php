require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "b5443b00b0bccb1d998af962becd8c20953ec55bb0c355ed14d36b7d01eb69c7" => :sierra
    sha256 "375158c80519e0607fd8a1efd0dcb9f81c38de92e62c5abc41a3eb7a1d2b4558" => :el_capitan
    sha256 "9c609f1106bbcb72d7cc03ade876d21be81eaff1fda775785486158854f75f38" => :yosemite
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

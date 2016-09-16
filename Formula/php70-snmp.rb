require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "5510bb55678586f449cde2a7634ec91fbf3654931e50f2a46366c70cba7beef2" => :el_capitan
    sha256 "fd968a9623164a9fb4c0f90a11d4aa13d6a40fcd93955c1ebe643bbec6ea5ed3" => :yosemite
    sha256 "1c1bcadfb94615d0b45abca7f3790f193d20caed27a9ba152a496a7c7575b7c9" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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

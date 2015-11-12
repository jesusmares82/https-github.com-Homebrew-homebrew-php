require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 6
    sha256 "e6c51c4d17dbef713571fabb1fdbf5231c1b10bc8438d78cdb1558beb636f3bf" => :el_capitan
    sha256 "e2370e392962478b505efe107485ab0e0fee81be043b4be7874ce155b1d4a913" => :yosemite
    sha256 "759d3b48d037b0b54299322e852099eb4332f6a7543faf4cc6aa763464edc9cf" => :mavericks
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

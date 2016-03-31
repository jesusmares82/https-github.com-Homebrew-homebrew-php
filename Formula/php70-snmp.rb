require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "60eb93f2f54f13aa5dace9d05815acd37347985aef278b88fcb2956b4a90e4d3" => :el_capitan
    sha256 "562584b242b9d10886d64c19cf540cff124a6dc312e311399966b157bd894b7a" => :yosemite
    sha256 "6cc7fe90bd4c85945a23a6b27a38f4dd991cb6885a4c6c1c7fb822670d1b863d" => :mavericks
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






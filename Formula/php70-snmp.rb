require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 11
    sha256 "0291ff31d275f219283fd4e04e895ec135e5e299c7e89dce99cd8e497c52e7f6" => :el_capitan
    sha256 "86bf2229293daf224f8e3c8cf21ab8bdb17da2e980c6ae6abf63ba900a7f33e2" => :yosemite
    sha256 "bc0aecbed4ad3c8bae014e43a4f3b8fe3392537ef8be4d5c3c8daffedc752d67" => :mavericks
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




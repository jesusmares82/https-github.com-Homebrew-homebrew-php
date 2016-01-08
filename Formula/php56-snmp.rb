require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "e6d4e4e158ea7300c2e78f4df6d112a82157accff906eff77b8dd3a97798de81" => :el_capitan
    sha256 "2ca04aa39170575bad52b4b89507ed5c0352bf6f1038a276be271264750752d8" => :yosemite
    sha256 "5e5206cd13a061e73096d2c1b3248bbdba9be96f1b12bc6656e2a0c210e6d640" => :mavericks
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


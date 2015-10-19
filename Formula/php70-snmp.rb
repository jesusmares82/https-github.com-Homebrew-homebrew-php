require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 4
    sha256 "6d62798d97e58884607f110a7d936eb4b1ff13209e6c0799872a777247998cba" => :el_capitan
    sha256 "8a5cc19275b49ef27d10ad06818c01d48aa8e3625869bfbd6631329299574611" => :yosemite
    sha256 "5fdcf7bf76c559a7c9e08ea68ce797780e72cdca8c75485a9f52189cb20e7681" => :mavericks
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

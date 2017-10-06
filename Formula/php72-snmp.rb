require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 4

  bottle do
    sha256 "cf0bc5e01c027328de9c4ab7753b132afe7e525052d98b25c32a5ecd0cdaf1cc" => :high_sierra
    sha256 "743ac8597840db77a1dfb4a084acf37f8f80f9fae89326fee7d07c2cf09d296d" => :sierra
    sha256 "9d0f567d943dff167bedf62e342cf5566ace8afcd9bb3f7ffbc2ec9f78d70dbd" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

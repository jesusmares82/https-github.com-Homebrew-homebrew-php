require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 12

  bottle do
    sha256 "3862bbc05a770a08ea821a8e45744f48dac9ee05dedac0d62f241e445c60e19d" => :sierra
    sha256 "7c1a4e6cc9e42c439a172984179d8dfeb5f84f835155b3f7f854784ea4ad1860" => :el_capitan
    sha256 "23d64011b7a4a6e70def94f14d7d31ef110f839a5bf38c17bc15684215e27b1d" => :yosemite
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

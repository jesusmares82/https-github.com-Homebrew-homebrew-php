require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 11
    sha256 "30007c4ef68d56da4ba85b02e3979fe6cfcaf932cfb2060e026a7cfc21fee311" => :el_capitan
    sha256 "c9428c60f314b7d8742a3b16c3ca566b6182cc58e24321b7cd5dc3c324787fbb" => :yosemite
    sha256 "eb7f59224fac114a1d36b6d085d8b33e8cdca1234b271fc1e363dda286a5722f" => :mavericks
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









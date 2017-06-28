require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"

  bottle do
    sha256 "80ddd877f587f974af3d45c74294c9bdba637c67d39f89511325f619702afa0e" => :sierra
    sha256 "52c43398bc861425925685902bdc5656c05cddc4811db227099e87e22a14982f" => :el_capitan
    sha256 "02a5a26b7c63a65c453e5f488b236decca3cbc328e7feca44e17da91bfcfbf80" => :yosemite
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

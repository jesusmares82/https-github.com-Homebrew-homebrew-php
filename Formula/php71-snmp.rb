require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 10

  bottle do
    sha256 "3072c7f46bed8b5ac83ae33511728634cc949483f206174b4b4b95bf1b24ce5d" => :sierra
    sha256 "192c8e951a22f44e96ec45bb3ece797ce110ef0d4c8f853a9dd99e144467ad01" => :el_capitan
    sha256 "eb26ad1c11964c8fe78e549026640ef310dcac03794461bb28a133f51c015a1b" => :yosemite
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

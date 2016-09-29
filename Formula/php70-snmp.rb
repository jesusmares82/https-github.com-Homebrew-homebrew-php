require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "79fe84589a3974b3b559e61e97d09a25ed90c8f67a4d5eacad0d6c0c95465405" => :sierra
    sha256 "de281c1235c1a4b7ecfeb14bd3f98dc9d870fc6bf421da6fe4267d79556e987e" => :el_capitan
    sha256 "cf5b5f3841eaa3fa2fadad9206bd9c027ba815ec7c68694084ab28ed460cabd9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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

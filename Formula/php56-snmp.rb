require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "c94859f9412cc30add74f0296cde472f61925a09f7a468a08d9637ab49e607ae" => :sierra
    sha256 "71b2639268068fabe0f79a4e0ddc2a7362180d70b3af8e0d43bc17763feb34e8" => :el_capitan
    sha256 "d2d8c1c3e5fa9e03e111a9e8a3c44b0a927e7b84c7fe8f40be60f7c22456b4a2" => :yosemite
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

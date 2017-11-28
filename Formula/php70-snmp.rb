require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 17

  bottle do
    sha256 "b31e6dbc2906f2fd3e22d33f648100f217bb03756cb335d5e9c00e81caa9ed27" => :high_sierra
    sha256 "190aede0d97337b70fb4bb1995254bbc6fd970efc9041b31583e5514b8e71886" => :sierra
    sha256 "e743cb3ca07812580efa1a3de6ddbb0ae07284181e01bfab0c4a08abc4bb9643" => :el_capitan
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

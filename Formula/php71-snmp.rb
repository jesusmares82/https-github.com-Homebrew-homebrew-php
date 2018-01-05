require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 18

  bottle do
    sha256 "739ebef72fce0881c28717a7cebb2d73d17ca6b93876fab145c8d8782d4e4b7a" => :high_sierra
    sha256 "1f8443ef2fa3d49618051ee94843948dbaab15126d160f9bf6f9b3674157af8e" => :sierra
    sha256 "d1e32383d22ff20e30d34f337fd6a658299cf5b6cc29facb6827faba1b5a0233" => :el_capitan
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

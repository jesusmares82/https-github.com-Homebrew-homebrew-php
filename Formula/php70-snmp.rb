require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 5
    sha256 "6f9afb5d2b3f354cfeb90d2bdf8a6eeedcf94f43ac93fe0b83d2a5faee59eb75" => :el_capitan
    sha256 "666846174bbaf229ed7f86b936e8a21559f10eae44dcf18e9a121e86e9be32db" => :yosemite
    sha256 "e30b6a71068992f67882f1eb17bbcd44340c1f795bfd369a2997594849e375c0" => :mavericks
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

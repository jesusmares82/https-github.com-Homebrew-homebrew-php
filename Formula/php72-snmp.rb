require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "4591f6c4d715527140d67b32dc075f4f727bbe2dcd1f7cca7263d6b32fa4dbff" => :high_sierra
    sha256 "e0ba4ae926f86107b3d2087359f504fc66c01f629563636c2ebfd893eaeb44ea" => :sierra
    sha256 "dcf6e14294b40cc5e49bde7ea0cb887c9a5c6837c3626c515b6cf817a9758d66" => :el_capitan
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

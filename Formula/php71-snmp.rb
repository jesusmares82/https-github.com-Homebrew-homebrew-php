require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 12

  bottle do
    sha256 "7be47d9f644b36c901ce89844b079cdc69c44b9f50f7f880bb6079c2b36ff876" => :sierra
    sha256 "a0cf8f36597cb43e04b35a4612cd37c140fb39afcdfcf7b75bd572c6971d818e" => :el_capitan
    sha256 "74ff9c7c93f6a8e69323037ed136466f019d56db150f5ae91a026917166a2f5f" => :yosemite
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

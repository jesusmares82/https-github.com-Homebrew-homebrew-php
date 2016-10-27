require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "c0e3d7e94e7e50ff7686a21a6e40d252f9af87419a0b2028d476992121d6de78" => :sierra
    sha256 "eb4ef1044e8e6007a7a85b898b7d0f6450f2bfefc23df27714cf2d5f2c9d86f7" => :el_capitan
    sha256 "dce6990be644c3a7a52110d8e841b4f6e2d9c919a82cb19f55f7443c1a9736f4" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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

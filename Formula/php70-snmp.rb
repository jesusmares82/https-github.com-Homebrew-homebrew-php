require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "041e53e21a3188cafe1506a3e12a838d809801faffcaa415ef346740ef9171d5" => :el_capitan
    sha256 "16cc5be25a3dfae18a01f65071f988a500732971aba2bfc16c01dbdaca07ed5c" => :yosemite
    sha256 "6b72a2e2301b19409220fbc3ec45657303171cbd106d8956abfd2b2835d4b104" => :mavericks
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

  test do
    shell_output("php -m").include?("snmp")
  end
end

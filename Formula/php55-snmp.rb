require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "83ca8c501ea1f4d0671dc97a181732d5226ae78876721f36eee9a0bfdd2da3c8" => :el_capitan
    sha256 "0f5e8dc16731d328b52813dbe334fcb07bcdea185f4b9cfbe67d8343b126dc60" => :yosemite
    sha256 "10dd7b64726b18fb31791c4bf8c3d1539d9c51ac9eca5efe4342bea442d8a87f" => :mavericks
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

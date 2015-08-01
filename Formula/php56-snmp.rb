require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "1aa5c19f50d142858026e8613999c1912e825acd2380c5cbed279e1b2273b873" => :yosemite
    sha256 "67e1429fb714f9ed10ec3b506b2a55bb95053a6439c4b848d3239c630c283220" => :mavericks
    sha256 "37d5c335aeec5ccef2f2416e0201cd41ae04538608f0ddc107d0e4b74d0d6a80" => :mountain_lion
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

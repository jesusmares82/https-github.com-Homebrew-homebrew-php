require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "e0480561c2408209f0b442ede6b1b83d079d0eef44ed1336dc9f927c51fb94c1" => :el_capitan
    sha256 "db7a56b675b423e428bf7eb4a201c5b783a6b42b15db897c20976fbdb2cbcbb2" => :yosemite
    sha256 "1fc37792a05cbdf5f738ec19eda0e1c57a8fd93d6b3fb034106d2d216b4d3946" => :mavericks
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




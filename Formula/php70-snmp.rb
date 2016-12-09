require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 6

  bottle do
    sha256 "3b93a8a81125fa13cfd728ba4cf165e93ae392f8a08e5cca195550544e939b3e" => :sierra
    sha256 "a622ed8b4442530077093aafbc443d7aca29876393df88824a49391dfdbf7f41" => :el_capitan
    sha256 "49f901d62f48459a779c1c3986880b0eb9bcfbc64644eed6de5b85b330009e2c" => :yosemite
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

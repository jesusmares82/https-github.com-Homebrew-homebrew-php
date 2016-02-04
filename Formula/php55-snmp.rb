require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "ab87f77b840ad4ae506d969e3f7f35e3ce05a1482094750de943ff672c44a935" => :el_capitan
    sha256 "e34752a5bc90d0f19f5f1024d477b72d7874c5d2764b0473ac6b232f8c328850" => :yosemite
    sha256 "435a2ad38032081db81cae64bf051163bf57792a3da59d47c197b119b3977745" => :mavericks
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



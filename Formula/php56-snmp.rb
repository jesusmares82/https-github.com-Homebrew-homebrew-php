require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "fab0b83c73900e6b5748122c6c8dff542f007b3e7a07d20c94e94482db70452f" => :el_capitan
    sha256 "026a9051b472e13eeb4ada416e9da25f793a836538ab25de0cf75fdc2602f82b" => :yosemite
    sha256 "2c90e0af9a970484c4592ecc23c4854952dbbdee0e7f38d3d60ab1789b76b8ba" => :mavericks
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






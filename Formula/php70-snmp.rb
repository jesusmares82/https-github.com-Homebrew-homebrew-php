require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 10
    sha256 "e66db9c109916d3c571c6ae7a5b4a8361a01b03dd1edbc68e2a750251ad9b61a" => :el_capitan
    sha256 "45e1248817d2039e2559a9d6903de8bb5000e4e373e5c762f82524796896dcbc" => :yosemite
    sha256 "7cb1b640c485c651a070ad7a9bf9353510ff784a59e6e56fe7397749a596ff25" => :mavericks
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



require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "ee0091ff48f9c74ad726ab0394dcd603d670aa8e00244116027afc3ffa3b8f27" => :el_capitan
    sha256 "9db5a21e5dde80bbfb8a8dd60c2a953a6357d861196a60003771236648ca9fec" => :yosemite
    sha256 "008fe429f347a538cb8b4faddd266e73b5a009e98361a5da76c9bfd375fda3af" => :mavericks
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 10
    sha256 "1b360dd625c2d6b67b7036640c329a7aa4d5595dbd8a7fe486947c9bcf9277fa" => :el_capitan
    sha256 "ce7c887b73cc4d65fe459630b7744547b7889099ec58809445ae38d0620db6e2" => :yosemite
    sha256 "d54f7df8b03701dc93c5fedbc70079f85fca9497ab2accf61fcc952e1205590b" => :mavericks
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








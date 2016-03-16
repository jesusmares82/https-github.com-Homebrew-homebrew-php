require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 12
    sha256 "d8d647165b047bd3653ca4f8fe6b4e6d4dccf951d97167fd50c73f5bef3b243c" => :el_capitan
    sha256 "bfb4652e316c31d5f93397db6008a17c1975f97e1216095cf9012c90f28623a6" => :yosemite
    sha256 "06b89735a5d2dd7c25fe9f48214acb5c4d05a0a69a299dc540ded13a7fc17521" => :mavericks
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





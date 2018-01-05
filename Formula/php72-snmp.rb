require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 9

  bottle do
    sha256 "f77dbaf55a4309796d83ee0aea43d6100c5cd5159dd686c289f7fd95732999c7" => :high_sierra
    sha256 "5c3947b3fe50e7e8b4a82ef34f8c10e8a0f548f27bd571353bcef62ed03ee011" => :sierra
    sha256 "24ead478463329fc1fb339364056dc4347b997f9046f969e165893bc4964ef09" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

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

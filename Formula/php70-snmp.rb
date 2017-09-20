require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 14

  bottle do
    sha256 "69c2211cb480bc8e146ed993a43beeb9ea7001048173b72b5e1f56f0e87c3a8c" => :sierra
    sha256 "e08f93780f0c1ed7c1151da51e9185eabf93261c7305aa57e0bbb4215376c157" => :el_capitan
    sha256 "88fa3381b34b626a18cc6006a2541816c27ecd4bcef548fc9274bbe812ea0552" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

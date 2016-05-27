require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 9
    sha256 "d94c1815df15706378d3867b0c7714acbe2c437052f82db802d1ed3aa3f85f69" => :el_capitan
    sha256 "76a90702eb2b99f0410bc1f61d05571cc78278e69a9317ac2a0bb2e7d65fa43c" => :yosemite
    sha256 "3737b956c171f219eea201f3bdf0295153ee1cd79b47beec1e728814d210ee0d" => :mavericks
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







require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 16

  bottle do
    sha256 "b3ed315111528c5fc757ef91cbe6986f09faa29dccf4ffdd1a21fa18ec2c59ea" => :high_sierra
    sha256 "1640ceebbeebea7ba8d24a77506a962b9dfc2e7c02964d11faf70a9863e0bfe4" => :sierra
    sha256 "eb3e01ef36e3b437be79feb0299717bce657013505d505b4926d801f48a3fd9a" => :el_capitan
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

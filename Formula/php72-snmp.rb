require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 6

  bottle do
    sha256 "0025dd989cac4050fd6a98bc74d814911ba56e39ff9c35c1764c88addcc82c3e" => :high_sierra
    sha256 "5337b68568549664798b4319c0bf8bcc24fbb2512caf5b4a81bd3b7cc4ea04a9" => :sierra
    sha256 "e54ab9fc2b24b2802e1aa7ca34716859e6b85157f7fc241aec207435d2453317" => :el_capitan
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

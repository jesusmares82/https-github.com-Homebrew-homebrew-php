require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 18

  bottle do
    sha256 "52e3b47a2c855dad00fc585637594661a321bf50a703afc7f4c870b017759d8d" => :high_sierra
    sha256 "8317240ff3e928e80ff86bf6096491965d824d27cf91cf62a561beb416712e96" => :sierra
    sha256 "28a7c942b38539302e053f411e09d84a929271e141a5e924968832cf10e84c0e" => :el_capitan
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

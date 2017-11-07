require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "18532cf7ac0612b938073eeadb220be07f4e8170fa120e45794b2f4983a890d9" => :high_sierra
    sha256 "da19a56d062a4df318279f26079d9d46e79dc1bb4d71bbbe998236a0d6c46ea4" => :sierra
    sha256 "471617ae72f77e62b932114e70f95ceef723c182756c066408672923e9307711" => :el_capitan
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

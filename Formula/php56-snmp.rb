require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 5

  bottle do
    sha256 "a8b3fbe83d404e1209f60b6c6a991a09317fa7e3c26d8e97e20976aebb0da2b2" => :high_sierra
    sha256 "25c44b48a26e2d0745d26725cf976ef525a86ce486a9bfc300b049d56d8bf6e0" => :sierra
    sha256 "161d2e98a46eccc347c634b60e52d694a4e7416b0cca0e6232e5356a50d1023e" => :el_capitan
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 7

  bottle do
    sha256 "b619469068bb706a3d119b1c91a0025500ac4baaee040cac21cbb69306c39846" => :sierra
    sha256 "0e9c8c730bcdf1d31061c213387c22c45ea35760b09e772e417c16ec1223f93d" => :el_capitan
    sha256 "cdfca822909f8047a2556934ee45ad512a3c7920bf3b8d063a696c4677fbacc8" => :yosemite
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

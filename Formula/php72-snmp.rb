require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Snmp < AbstractPhp72Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 9

  bottle do
    sha256 "533e91d569b7da7337efd848dee9008cad986f49950b831515399ecff0f0d151" => :high_sierra
    sha256 "2eaeb2ae17dd6993e334303235e3a2dfd3cc1de6c7b719d019958b8b3cff03f6" => :sierra
    sha256 "e125a3503abe9e42ff1f9a584841ddacd4be437abaf21b1a0c5ad8bd5ffb5fc8" => :el_capitan
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

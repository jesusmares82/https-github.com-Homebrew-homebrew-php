require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "3e864461892153f89d10624a822b6887bd04c4f8cfdef6f1f51fd7906be02ec9" => :el_capitan
    sha256 "c36aa3c9227f8cc8385d448c50f43042aafcf9474b63525df138e8a7eebb7413" => :yosemite
    sha256 "5f189d3a9b7d9e6c45a41c63ed53ccb26d735acd2f5ab1ee18c20885116c1c1d" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 15

  bottle do
    sha256 "71baa0f2e9e052bace429f4e4dc6e7eceefbbd7a1651c666152a0a2b4e678f42" => :high_sierra
    sha256 "3d46397d65d91942c67aa1c6d926f15e539aa534292d33639dc7fe1e9dd9ada2" => :sierra
    sha256 "33cc7807cf3670437f170ec757aef1dc1e3ccc10e55ebdc42fdfd4693d8276c3" => :el_capitan
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

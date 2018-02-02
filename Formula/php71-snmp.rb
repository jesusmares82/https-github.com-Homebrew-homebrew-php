require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 19

  bottle do
    sha256 "1b09f08f77a4a694d8cc993492eb652803df87273d6ec76916d8694ebf0c723e" => :high_sierra
    sha256 "7c92ec5e30c561c943a419f1e0cb7a5fff21998894460a8820c594108f1e30fb" => :sierra
    sha256 "9105f8f0c97ee1257be97af2fde991678628be7cb815e78f0fc110a0d3030fa3" => :el_capitan
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

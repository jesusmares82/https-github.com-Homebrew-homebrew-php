require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 13

  bottle do
    sha256 "5d51958be9295e3f6eac306e8afd2cf70d89cb7ac4fcfc43d9060aa494f22edc" => :sierra
    sha256 "fd732dce6a35ad077a3d61969038078e08f21f09adb2e51a83baa74f8085525f" => :el_capitan
    sha256 "a969545fe793d45287ff490ea90e61695d9c23d8085fc9574f8c48d091c913f0" => :yosemite
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

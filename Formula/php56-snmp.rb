require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "758b4c4693671f50c0b27b3e37aa6b0ff23a8f935609e623f2816ef1c8076b4a" => :el_capitan
    sha256 "adb29caacda60c6d3d7e0619eb85e496eff1a1b39cf28c5e691c3b559add608b" => :yosemite
    sha256 "33d5aedb7b021a86f9efaca5d76f8f7df98a20a28ad9317c278a72db49ced732" => :mavericks
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



require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 11

  bottle do
    sha256 "74b7b7c3707e99c532997a8933c440e884a9c497ab15d6ff13bb6507ec9107eb" => :sierra
    sha256 "ca2d8f5d12e45f1dde1319ed54b3636da900e384196e9d7ce87ffa97e8205bb2" => :el_capitan
    sha256 "126ba08f1c0f29d729d7f6462c6c12f3dbac9c6a525108563f3c23ce3674f372" => :yosemite
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

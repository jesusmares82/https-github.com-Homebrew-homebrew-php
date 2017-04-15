require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 9

  bottle do
    sha256 "06382b46d10e89853aa64cc4bae8fab82629ac2d21b5e9a3486da9153a5a6db9" => :sierra
    sha256 "d261be10614b02925b0012256529a2e9feb0e6a38cc97d8f758aa496b0fe3d43" => :el_capitan
    sha256 "6f60893c90bc7ebc9f56001f0ba95e1b299770cb89e4d8c981f03a8b62311bc6" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 16

  bottle do
    sha256 "364777662b8fad5f7133468345ff2d68639252e71c7e282e3f7ce5c7bd4dcc4b" => :high_sierra
    sha256 "942ee644f992db35e30866c0c121e4a8127bf7d9d01197301c0c3ca302476aa5" => :sierra
    sha256 "0e63b42be640c9f91ead6913c9b60a094b40fc4179945f175abcdf611e40bd8c" => :el_capitan
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

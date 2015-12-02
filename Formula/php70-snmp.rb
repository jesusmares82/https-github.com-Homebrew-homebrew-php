require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 8
    sha256 "bcc31200ab5b8c536778cd966a96af03960da9f74cf0f6e346a79701daa44663" => :el_capitan
    sha256 "6145430b4b1826f6fa0c9abda6f15ff956d81709f3d144a570130b032fbfdcf4" => :yosemite
    sha256 "6d30507bc775951eab22e74c3cbbe4ebe76b0dc4038cec7f5cbee7a9aeabe26b" => :mavericks
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

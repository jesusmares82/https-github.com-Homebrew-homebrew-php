require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "https://php.net/manual/en/book.snmp.php"
  revision 15

  bottle do
    sha256 "249330b698a1de765fd433927c663ffa36776211a45dc6e3b089af4d122c9083" => :sierra
    sha256 "63f597dddf7a7bbed9b5e1041cdfae367dcc4313ee37fddfe8b78b363c6be0fb" => :el_capitan
    sha256 "e87916a6f037a1943409a95be4fe3575f12164c0199d5a5add1f26ffdf8b9f9c" => :yosemite
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

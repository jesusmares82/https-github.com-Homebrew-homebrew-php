require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  revision 9

  bottle do
    sha256 "1d6c2d046f126a587f5a83f625b29d55937b5d2e767afc563bfc1c643088f13c" => :sierra
    sha256 "509267da992b5034ec13d7f62a553d1a786a7e405fc6f5c7d57d1037972817ba" => :el_capitan
    sha256 "5d485bef5fed167831d03a7faa6ea6f023ffb2b1e8a6ee6200dc71873156fc0c" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 14

  bottle do
    sha256 "44afd52aeee4a58b52fc9a973633ce02afd00786fb7282f73a30340a5408f598" => :sierra
    sha256 "1f11ef1a553be464df4e977fab03e5823f5bdeacc1b39c75e8d6b77b69b8a090" => :el_capitan
    sha256 "66b99fb3f5b9e97eb81d2c8edda7496554f9a8b1e18e04ad13f09070f795b830" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end

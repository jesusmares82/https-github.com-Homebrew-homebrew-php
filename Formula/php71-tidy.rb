require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 10

  bottle do
    sha256 "722614949b639354e9a883373ef29511a853779f98e621e3edbf2f3cbd4f68ff" => :sierra
    sha256 "badc3ef234ce69541e66304d347c6c03a27b5f59389479d11214a39ec68626b5" => :el_capitan
    sha256 "390a29ce755e75199bddc794126c0c51b2aaa94b0fa4e296f9352d68e17655bb" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 12

  bottle do
    sha256 "8b6f924226f5093dbc672df70de19dfc2712033731a190d9e08353f52131b589" => :sierra
    sha256 "f068f7509a61a16786dd5e1228820c97bc9c9b41519ec5eed124592f378941f7" => :el_capitan
    sha256 "07b8b83c6711cb047502748b53620917ba4d2403fe7eb2c7a1af35afd74dd3b0" => :yosemite
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

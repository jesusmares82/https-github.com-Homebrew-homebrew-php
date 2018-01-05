require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 18

  bottle do
    sha256 "586bd20fa2451783a6ffd83ab00469cdd69477f4f2a6481b692f26d834898810" => :high_sierra
    sha256 "2254f9ee091fed5eb64a2b72ea3ed353f131b7b91a38a02a237808b9a533e9e3" => :sierra
    sha256 "01f5d11e2e0e770274f728db42fe830b82b06ceb967c554248a05da19cf012a3" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

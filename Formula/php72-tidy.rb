require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 8

  bottle do
    sha256 "2404bd4576a96a13678bc2eb0c22b7a629ea4687d709d872e645e588acc0598d" => :high_sierra
    sha256 "f27816b26d98e92921886c907262343555488731c15f3fec1ac56fbd9e813eee" => :sierra
    sha256 "844eae9a7c160b30889d7d1484468e97fbfa9b6d3ff9a4b37d0a5a75e481d74f" => :el_capitan
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

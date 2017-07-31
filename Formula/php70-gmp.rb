require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 12

  bottle do
    sha256 "4bd5425b55bcb6c3ab40562f8e69a53b36ddb124414755cf5e406dc524cf1bd4" => :sierra
    sha256 "664ff48a011403ae9bda940922dfd2da018ab46122a481029714a078550962b6" => :el_capitan
    sha256 "98b3780ff41f7db2900b5a37da670619a788aee66bf772f69bd73cd2f5231da2" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end

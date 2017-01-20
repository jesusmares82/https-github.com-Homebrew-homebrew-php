require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 7

  bottle do
    sha256 "572ed6e11e6e44a417f55d442886d5ad4a78529560858767773c351966a262c5" => :sierra
    sha256 "6f8459ea5aef8594ad6f35d063320bcfb54a195279e730e6d7a8f4a5c47c64a0" => :el_capitan
    sha256 "8cbddb87ce716695d5248429f0475de2e6e8e32e2fc529b907d8d107a535d4f9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 5

  bottle do
    sha256 "3d2bb3f1c9ecff48f53c08abd9ef9fd801516d9750bb4d2fc525114c932ce6b2" => :sierra
    sha256 "c6e5db24d17634a8d2c799bda346c7dd2e22a5330030b8d463bc308fa41dc802" => :el_capitan
    sha256 "35d7147c0931f961734b795bd9d273ab26e75cefa95fc92015e1a4b4fb62ce25" => :yosemite
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

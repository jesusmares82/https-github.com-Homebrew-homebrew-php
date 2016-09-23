require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "fbd214bd7a8c4e9c52a5f31af1742f938909dbd17b3f2ea86016fab9796ac0b7" => :sierra
    sha256 "7d3fb39eadcb0ee14307ff0e59fdaf1e5dcd2cefd191b702abee542379ea7592" => :el_capitan
    sha256 "3c43524a0aebccf825813773773b8c3925de81f4f18c6b1bbbd83966a4f4e49a" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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

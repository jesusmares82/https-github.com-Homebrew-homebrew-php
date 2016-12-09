require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "74fb16591bc14a211ef28f9a86f879b5ea50d6c3283c6f87447835b58e7d0dcf" => :sierra
    sha256 "375a46d9596c5046a239faf0fc84d354b815f507b728f1b7cfa85f8d1e3d3647" => :el_capitan
    sha256 "50974ada96478b4f2d1aea80d91512a6374869a49cdb806c44257201752f654e" => :yosemite
  end

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

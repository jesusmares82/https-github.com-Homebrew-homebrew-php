require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 7
    sha256 "763a03a158db517ed16d9284492b2f2b88fc0b85d6986782b103d7f46d0ad782" => :el_capitan
    sha256 "c3229e40274fd85c71d74f7440d174dee51c9a65ee7667e9558b511e587bf62c" => :yosemite
    sha256 "e53e280051a4f1162c403dc07bc6b58f021a989440d4377ba10ca80fb9c39336" => :mavericks
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

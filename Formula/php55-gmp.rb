require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "f0d50c7dcb0baeef2f68a2979c84090a1a51772faeaee7f8d074b6115721c4bc" => :el_capitan
    sha256 "b8711978b7ecfcc815edfe2c9f1b93e5a0a986ef4ae89d906e1d490b87a45e44" => :yosemite
    sha256 "7268d13c302d262eebe438997d4639be89992684a0a6fa7ca8f883fd38b00c63" => :mavericks
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

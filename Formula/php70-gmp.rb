require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 9

  bottle do
    sha256 "9c4bc2cc8a1815aa353a896bcb7030b8083f77e538708a9969b683b62e075389" => :sierra
    sha256 "ae09c195bf48ffb5bdd07f71d5fc5cc1c733368036382e68034e0608b0684a66" => :el_capitan
    sha256 "bcc7f6b66dcb66ef1ccb5af1c9674496eec647c38f0d84a12956a56c3c0f2577" => :yosemite
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

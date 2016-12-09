require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 6

  bottle do
    sha256 "8c84aa59a11af41ff016b6e6fd59ea5ca4e83c955ba11c4661506821d7409d91" => :sierra
    sha256 "85db83cf041e6ea054fd8b72f103ac1e0685386c4692f6c1f4ac1fa50f302fee" => :el_capitan
    sha256 "1fe4ffe0dd05c779a538c45df00524fe54db271ae782a8fc21f392c9b84e76ec" => :yosemite
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

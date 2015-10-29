require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 5
    sha256 "13b8ae5822637624734edabb707ccc7a45513a51c05fd94d5f0a87baf02262e6" => :el_capitan
    sha256 "465373bdb578901375054e16967ba3747003e76d73df33079803bf0d0c7c6f51" => :yosemite
    sha256 "49230cfabae4cf04e80515ccf949b9cfa565707944bc974feee8245b043dc597" => :mavericks
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

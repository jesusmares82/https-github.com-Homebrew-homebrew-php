require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "7129a1c4ae6103eb43e4c9a3ed5b7f00cea664e0fa8b7707f7684fd7e2ea7c0a" => :el_capitan
    sha256 "acf931236a3b43b4fad48840b47c8a2b66260a308466d83ab0e6744cbfa0fe8a" => :yosemite
    sha256 "cae1cb2368448a402719729ed5c5f3af07306847fe067f6af0a56fa150c8d295" => :mavericks
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






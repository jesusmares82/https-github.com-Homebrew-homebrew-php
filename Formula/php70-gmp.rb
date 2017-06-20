require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 11

  bottle do
    sha256 "9296e895c357640488a4c1896296fc4bca48598ec153820418b645f8036a82d8" => :sierra
    sha256 "0244aafa1201ad0d8769a5259faefae4e10879a1679d04723024e2410d7a3aa5" => :el_capitan
    sha256 "a9f1c187ed735866b16cd0349e8245cb772ebdd9df94a7ad8800a51533b4626e" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

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

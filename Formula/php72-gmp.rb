require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 9

  bottle do
    sha256 "1af931feab00683a5d6634a0e50b150284c3763386ff1b3aa29d9a21e0f7c2f8" => :high_sierra
    sha256 "356251dd8de45f6ac981f2ce4b7365e8370200927bd7ee25d69221ddface16da" => :sierra
    sha256 "e821d45e19c2dcca3bb8cdc6344f843b9c768c8daf7bd1e596d7ee768eb344f6" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

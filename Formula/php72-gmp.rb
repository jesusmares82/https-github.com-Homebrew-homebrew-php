require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 7

  bottle do
    sha256 "5ba27db9ab760efb9305ff83b76ec23b137282abbc80df2bda94cb81146555a3" => :high_sierra
    sha256 "7996a1fc6241b007f9c09300fd35146f0883a5d2aa59962479a034ba52f6b751" => :sierra
    sha256 "e8a97765959ff586958c2504f8ee5698ee221661fc37b9a60c1a680b3675bb6c" => :el_capitan
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

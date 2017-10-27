require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 16

  bottle do
    sha256 "2c83ec904757238cde9746f8ba59ba9c2b439db32aa33878e285d6154d3472ac" => :high_sierra
    sha256 "b5f93fd9ae62c442b4c4da44600fccf7d3dfb1c3b7f803eff31f6a072ac48fca" => :sierra
    sha256 "acb65df91475e809fc08fb830848d1bd3e1284a738d802e5a1ae711f84f44807" => :el_capitan
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

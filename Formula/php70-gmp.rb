require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 16

  bottle do
    sha256 "95f3f48b84fd151cd088d39e493257a47cb3843f282e6244c3247b25aa4d62fe" => :high_sierra
    sha256 "0da2ec090df7b3c9f4dc610477de47fc71ab55c68015cc737ecf5d08f839e14d" => :sierra
    sha256 "21f00a0d804f6828c1fdd682c0e49df2c046807518142f65074eda920ad47df0" => :el_capitan
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

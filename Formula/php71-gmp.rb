require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 18

  bottle do
    sha256 "35e5679b16bbee2c1ca9719b3fa6c252cd18cb07687d747cfc3f1f12a8b2fabc" => :high_sierra
    sha256 "2b28b2279db20408d43a859a13fae31bef0c3797d7083519ffc28eb93d019f15" => :sierra
    sha256 "7fccf62f4134d4cd8b1d79683b0e86da43a9cf0bfdbc5674cb3be7839e68b7bb" => :el_capitan
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

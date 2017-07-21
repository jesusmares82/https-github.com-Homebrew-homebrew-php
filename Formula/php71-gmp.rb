require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 13

  bottle do
    sha256 "89cbeb7e849f3cf60d4888b192173a37f261eed07bb14717dfa76ec679fc63a4" => :sierra
    sha256 "8cb7dfd522b122db05c61f17cb94c4296bc056af3723979507770cd69df9c3bd" => :el_capitan
    sha256 "c751bf628be17f82b5b0c8a74060946e5a27b1f7b7d0b18ea5475d5dc230c27d" => :yosemite
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

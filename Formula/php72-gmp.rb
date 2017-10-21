require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 5

  bottle do
    sha256 "798267284f669988ce575bf7bd6a28725f9e613f3a03cd11c524acec36771ea1" => :high_sierra
    sha256 "4ab6d27f731294e3c65521d5f59036db9b6df7c3578ae4aad94c8f022eb875df" => :sierra
    sha256 "aa72d74697999ca27ddc249a05397f040dbe7020f232cc05cd3acb2fbee19df0" => :el_capitan
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

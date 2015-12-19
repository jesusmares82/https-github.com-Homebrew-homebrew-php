require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 9
    sha256 "e863158c64b4e0e02ec437fca851df3017250f9d89884019fc76d6b91ee7cc07" => :el_capitan
    sha256 "068a95759c3bfcb476f5ff877e161abe68887fd6102e95368f1ea13d4b4647a7" => :yosemite
    sha256 "540c16b2db48164d2489cee738f0d0c726ad5ff3a49f062136cb81f1992f115b" => :mavericks
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


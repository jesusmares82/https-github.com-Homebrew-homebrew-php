require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 8

  bottle do
    sha256 "d7d1398d523b07cd3340b2c2173436f015f21df3a564cc8b2b250f77f23fe452" => :sierra
    sha256 "fd7c4175acb5cffb9b742b9995c36c05a0412506ce6fe7dd9b06157785418cff" => :el_capitan
    sha256 "8cc8ebc5f2e8dafabab815a4ea6d95ee9f1fd2684365f730fe597418cf9b6cbf" => :yosemite
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

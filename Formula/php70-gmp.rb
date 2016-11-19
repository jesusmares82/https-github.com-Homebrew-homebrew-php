require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 5

  bottle do
    sha256 "f9b0d97a5c96c15750e2f24b64725f4c124da6ec3f4b493ea4c7cfffc9f07ae5" => :sierra
    sha256 "f3e2a7247f65ac9106cf10f290005f9fe2c84d248a7a9c5cc3dc7ed4bb1f4dea" => :el_capitan
    sha256 "d1e8445880832e64c64ea15e84e2fae075670d0d4657a2f96eb69b9b20809ead" => :yosemite
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

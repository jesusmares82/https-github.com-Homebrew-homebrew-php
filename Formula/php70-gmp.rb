require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "2ec5ab00d100ad8a8b3dfd6844056c169805126ad91b76854754eb8acca54a5e" => :sierra
    sha256 "58599229cb8ede6df3114c554ee5a4125e4f9cdc330743db71adc966d6af96c1" => :el_capitan
    sha256 "6f103a353709a5cd69e485a104c5f8927179121b846c7aaefd36a05a2146daa3" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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

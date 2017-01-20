require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 7

  bottle do
    sha256 "aa71dd579a48694c53e23036d78966ed4cf10bf2126a8e3b68136a105a7d53ee" => :sierra
    sha256 "a33e0bde25c4e262b45e99be153747d8f3ffb1c0c047e7480eeb03ebb03611ed" => :el_capitan
    sha256 "fb1c6720ac182b3a0382723423bff6b64e9ed1e9007808a2401af945cbc81805" => :yosemite
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

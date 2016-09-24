require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "96141c8d2a6751963caedf4147fa7521b7ef5a38ccc1d2f8a37f2db6e99b05f1" => :el_capitan
    sha256 "efea6e0feaabce46ac0eb05eb5c44c05b6ff562312aef0abfbdcc23764b5abe9" => :yosemite
    sha256 "52055ab192b859d42050a0dd8f7279066b7137f4a1f29f6fe01be7210ca976e0" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    rebuild 12
    sha256 "a0171701fc4d7baa5fbdd7ffd2cd2558a7cdaa3559571513d9e1f675cfe5d34a" => :el_capitan
    sha256 "7000c7bec0215ab69ad54bc46f9c6d1542f28cc4c28fb251649e359cc7c6da49" => :yosemite
    sha256 "7a6896c0fb5ecf58877692a857b780ae2cea445a7be5d0482ed26aef3d816bd5" => :mavericks
  end

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

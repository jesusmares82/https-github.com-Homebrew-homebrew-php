require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 9

  bottle do
    sha256 "7b6edb37b4115b0d99d3ba79e687b5e539e408c9c4a263de6c004791f1f73e6c" => :sierra
    sha256 "77e2eafeb6fe2de52c4a1121e45c3010816ca274f68e8ca1db8a62c7ff28dc34" => :el_capitan
    sha256 "d9d0fe506603f9353baaf60930cc41361bb1c9e201baf394ee13775d1a95dd25" => :yosemite
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

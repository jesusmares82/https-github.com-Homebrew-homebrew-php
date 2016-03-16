require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 12
    sha256 "0c544a0b427296f37c81ba0975af1ad5c15a628aa62e1e15d7bce1645904f09a" => :el_capitan
    sha256 "796e7bb680d7899e0bc573dd857217869c5ef30de8fb71312503be76a60e52e1" => :yosemite
    sha256 "ebce07b5d30177a88822e7c2bd5925c4a65ff9dfd62c0d6602fa49e0b5cc7df3" => :mavericks
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





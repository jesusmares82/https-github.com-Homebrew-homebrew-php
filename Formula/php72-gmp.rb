require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"

  bottle do
    sha256 "e6a5739ecf8a8b2f8dbef098d17290ecc4a10a386811b882a108ff0872df1d86" => :sierra
    sha256 "e7e3e6a61b6b1b4b49efc115d773a86e6284460b79f299f1acfe67217d1fa26a" => :el_capitan
    sha256 "63e93a11bd38ed7e92aed1ea25f5ed8b210708f55c599ca1e745e6a54256eae2" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

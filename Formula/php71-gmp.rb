require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 11

  bottle do
    sha256 "27f090f0abcbdb790f1545060226081206d08bd5c1db39ddb7899cb05da77b8a" => :sierra
    sha256 "f3653ae8a5a08aa0b71bc01126aa4c90a5e3317864d123f1c3233324c51e398a" => :el_capitan
    sha256 "85211a33b58ca713fce4fe4e4cae84cc6c161b3b2d816b45920772f651b6c31c" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 3

  bottle do
    sha256 "bf456cdb94ccc82b2a996797141df27ad029b93d4bee24af343a543750bfd1ca" => :sierra
    sha256 "82100fb1ff6bff47db5176c3ce67955f9dd38cbddd6129a5b638f0fb91214569" => :el_capitan
    sha256 "e6abae8d307efd0fb7b4fba16f59fb81a7fe7642eb65d68ad4a9be4b99e3a381" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 4

  bottle do
    sha256 "a7fcf223501d625abada34f11ee4b3f66ff9e6f534472feff2f4ee877693f059" => :sierra
    sha256 "224b2ed917ec0ed021b6d1aaba0f6e25f621d2b8011b0cdca7f616df46ff115d" => :el_capitan
    sha256 "aad12a4e48ab56d725eb5b27417315ff12d544bf1fe82a228f81282f0bff21cb" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

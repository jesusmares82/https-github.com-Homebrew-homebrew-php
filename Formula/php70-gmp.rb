require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 15

  bottle do
    sha256 "4234f0bfc810f72d6e792927c042c21cd89407ec208446d395494a424a3550e1" => :high_sierra
    sha256 "12d33cc836bb75e7a97969613d202b7ffec7096f1f1dcd5159b0e022dec41b90" => :sierra
    sha256 "4b00b68131684d12ee85089440020d6d9692165b4030fe7acb4c7b97cd1ef714" => :el_capitan
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

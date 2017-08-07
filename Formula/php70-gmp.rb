require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 13

  bottle do
    sha256 "8e257708d740cb3d60c83e4a4f613aa2a0544766dded83d80d184fae505c878e" => :sierra
    sha256 "4cae6da43090b5124194a35e80b623101dcb262fc0115ff1d3c8feec0ccd747a" => :el_capitan
    sha256 "e7f931eb5b14947564f45fd1dcb16bdec91bfa14cd66b31ffbf8bd12b20480e6" => :yosemite
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

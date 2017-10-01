require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 15

  bottle do
    sha256 "4043b24078f6c822d66867dad829b0b1ba54724ddd1e65e9d1cf62b68ca3bf6c" => :high_sierra
    sha256 "ac8a65df19d0aeb9e0535c00255eb957dd1dc12233a66992d1996e14b8ee28d3" => :sierra
    sha256 "977c2572bc721c737413ecff23b54602faa807972f7e0d2cd3902e620178e074" => :el_capitan
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

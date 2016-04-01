require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "c29c8629a18bfa364803d653ad62a85e403d1d909b07036f35db09a87fdf0891" => :el_capitan
    sha256 "f5a622336a81bfc69e1a86bba3a623b0dc6b0dedf7fb88aa97fe441328e5ae33" => :yosemite
    sha256 "b819e4670e11852528b753ecc802533e1b197f23070ae2bb759e52bd01bb7994" => :mavericks
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





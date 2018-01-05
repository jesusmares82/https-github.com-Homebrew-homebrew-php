require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

  bottle do
    sha256 "97efe597edf3265afe2fb3a8229244e69e7e41ff51d47e58834b0713a31325f3" => :high_sierra
    sha256 "d837e7678996754b24ccbbac57dd2176302d8b36d8d46d6b2d34371a904cb2e2" => :sierra
    sha256 "8602fb294fa3ded33ff1e4753b66639a393fb46f3ead8d423d09a49d12f312c9" => :el_capitan
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

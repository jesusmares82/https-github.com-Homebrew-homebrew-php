require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gmp < AbstractPhp54Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "cf5fb8b04ca4e9058bbed2b69f121a7f2d85dfb2a1f3f28f9afc8409b6279d27" => :yosemite
    sha256 "60472e667ceb66edec5a5ff311bb757379aa7337c686da7f95b0f61d9077524d" => :mavericks
    sha256 "490733341a30133387c3954d6442974251823bbbc4115993b984835c91e68994" => :mountain_lion
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

  test do
    shell_output("php -m").include?("gmp")
  end
end

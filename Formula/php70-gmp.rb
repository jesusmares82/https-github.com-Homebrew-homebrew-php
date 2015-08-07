require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "09fe1093ec26f600923d1c3c51b8485a1dc864c074454071dd278a0fbcde36b5" => :yosemite
    sha256 "5c9b339bea106bb347c66bcdb2ea1a6db298b7767f31ec48fef858439ad4349b" => :mavericks
    sha256 "d2888a591de99c0429d6e91626add60aa7aa584b26ee91580aa55fb0a02caacd" => :mountain_lion
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

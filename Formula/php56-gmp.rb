require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 8
    sha256 "559aacd1f7c2baaec2abef3eecae512a9abf269e9e5f3d54b858bae979aee66a" => :el_capitan
    sha256 "7d00a12d6ab47a7eb31a5604535fb5eeb79437212a32cb85091d8f46e4e3cbce" => :yosemite
    sha256 "311ce3c96d9ec2b5f711ac20dacd305b0381938820df7af73495186f5ff8cb3c" => :mavericks
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






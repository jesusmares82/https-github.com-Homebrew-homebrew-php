require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "77d569f87223445f295c50729ba8b9063d1e19282d97cee6e9e4208974b1d512" => :el_capitan
    sha256 "5fdd923cfac17932aacb64bd4bf0069b78a9bc2aad6c7e08c1978603ac02aebd" => :yosemite
    sha256 "fe609e47ad492b246efacd1c2ef105f9ca0f99e6eb107f17c479804746f5282f" => :mavericks
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


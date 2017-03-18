require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 8

  bottle do
    sha256 "8620de2a37397fb4762d9e846e83e7777002b681d99af5288c6d066b8390dde2" => :sierra
    sha256 "56dc4228d243b7f458a4ed573380601955df6362836d22dd5cf8f6af4f35b05c" => :el_capitan
    sha256 "29b96a115636ecb1cf1a8b42b0a4346b6cd1cc63c84a0fbdba8347330e8cbab7" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

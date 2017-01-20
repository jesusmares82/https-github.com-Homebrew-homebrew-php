require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  revision 10

  bottle do
    sha256 "b3c0df2433736bfb21d73cfdf0b7b8eb3e2e2fb6dcffafd78db85bb28bb41ff7" => :sierra
    sha256 "7b8c0c251b6e3401bdee39e93b4f6ad442b47b64de7bc6536ed28b20ab81755b" => :el_capitan
    sha256 "ade1eb441405d8ba4dcbeeb596a683e0fe62a6cba50ef73b10dfea3ddae1ee31" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "icu4c"

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["icu4c"].prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end

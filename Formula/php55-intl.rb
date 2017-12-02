require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Intl < AbstractPhp55Extension
  init
  desc "A wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "092fcb46baba09384095271b8f1ab19cd71d44e1a0d101537d34ee981620e7d6" => :sierra
    sha256 "c601f655578e71f6e2b0a46cfc02aef6cb4ace2f05119457b2fd3025c5a677f4" => :el_capitan
    sha256 "e1b20f5392a5286fad7d38b8dba7e68100502b5c17b71b29c571b9a44feb6f2a" => :yosemite
  end

  depends_on "icu4c"

  needs :cxx11

  def install
    ENV.cxx11
    Dir.chdir "ext/intl"

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

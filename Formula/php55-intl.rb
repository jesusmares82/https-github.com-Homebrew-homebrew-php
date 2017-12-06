require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Intl < AbstractPhp55Extension
  init
  desc "A wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 5

  bottle do
    sha256 "6e66d658f7a6f961fcdf75b8f44ec1322dcf9833a4c9a8b82ae8c33eba16e525" => :high_sierra
    sha256 "0e3c7ef4b38bf53302b9a15212a203825072526b9451c289a457270708a9fa8e" => :sierra
    sha256 "91e48d21ec84b652f7d1b8cd90541a12942b1058000c5db6dd71782e8e586736" => :el_capitan
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

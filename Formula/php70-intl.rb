require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 21

  bottle do
    sha256 "568d66b83b2a2b8eb8a740ee67eb3e4866892e4b25f0716195834e989c43b5a2" => :high_sierra
    sha256 "8156bdcc4d0a78476da4de8d59cd4c69404f6bf92102b0666793bae3e4d8b2cd" => :sierra
    sha256 "ac05fca09c719423d6a58a6ad81ae1670316c9fa7dec217880f333271feb0b60" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

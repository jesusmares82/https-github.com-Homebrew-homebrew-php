require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 12

  bottle do
    sha256 "e718529b7ee141ac4654750060d0dae7b5ce5aba671b7278686bc81f63c04275" => :high_sierra
    sha256 "57c344ec4621ba984afe1545d02e0d4eef7e1ecb1604469672d56745fbdea173" => :sierra
    sha256 "eebfcf9d5ac6968c5ef17db29f17281c2221ddebefbe51d6425b726929b9c527" => :el_capitan
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

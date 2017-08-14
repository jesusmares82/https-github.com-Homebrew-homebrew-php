require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "c02e8ba6309f1553aced5c71a1db989569d8b4c05363b0968d13d0d9745b6885" => :sierra
    sha256 "f65d78961087e175eb24895bd2c0b3f9af275ba1f59e95bd3fbaa2d6a6069e99" => :el_capitan
    sha256 "a5ebe914a72c2f3c08cf46075789ce4f4caf9c4abf425b5422a816243b866a89" => :yosemite
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

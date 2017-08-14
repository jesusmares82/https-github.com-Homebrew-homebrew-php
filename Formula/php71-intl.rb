require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  revision 18

  bottle do
    sha256 "35c506becc3df8a64bee532c3510a8d3e2beb2d4a167686d4e7678dee8fead78" => :sierra
    sha256 "dbc80dd12f10c8c7864042d1b58a80dc7b320e13f3afe181e7261e8656d5b8f5" => :el_capitan
    sha256 "f250f1956043af8192e11f0c7c8a470718bcf63a4a1d6a019f773f4ae6222dbf" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

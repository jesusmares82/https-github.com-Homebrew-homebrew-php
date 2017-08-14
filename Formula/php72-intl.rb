require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"

  bottle do
    sha256 "88edb0c4d60e88d305c51ba80d5f4a14b5200a6ea43af660759565490e3bf0a3" => :sierra
    sha256 "aa5747464b6dd45dbcebf757e90eba89d28af7af5ab52791521c12adc93639b5" => :el_capitan
    sha256 "636080e8a8ee8c76d9ceca0db623023112ce5c73c93feec1c833e83b9b094525" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

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

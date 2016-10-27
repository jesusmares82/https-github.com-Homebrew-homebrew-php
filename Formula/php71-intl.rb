require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"

  bottle do
    sha256 "ffaf480cf7ddbe8ea125ee184cc2396674cddf9dc9e44c2b99372b0e5974337b" => :sierra
    sha256 "56e7e7d49c37c411fd1998c29a289e74c8c14ef1d25469fe370c60820e0799de" => :el_capitan
    sha256 "e2e0cf585d839d6d5e5c2c3920b1bda623d1fad27ae4b876d0e7aa05fc221581" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

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

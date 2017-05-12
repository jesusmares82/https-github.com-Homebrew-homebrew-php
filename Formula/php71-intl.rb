require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  revision 14

  bottle do
    sha256 "89b665588d18986a56d4893aea48eee5938ed176bd1dbe3812c63b92f3857da6" => :sierra
    sha256 "c3d88ee279422af150d8c626c283b5fcdd30c198902030b94bcbbb0300c1944c" => :el_capitan
    sha256 "2b7a376406580d4b3112f1c3bb7478f42e6bb3f8d75aabd78f92626d4155ac16" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "icu4c"

  def install
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

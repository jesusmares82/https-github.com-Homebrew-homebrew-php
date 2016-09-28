require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "Wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  bottle do
    sha256 "5e3dc22a691dfd1f23dca4c9ebb7ebd3efbebf8f44cfdb7a2512ae6fd3cb50fd" => :sierra
    sha256 "71f0690abbe6646bd778bfd3fd4aeb1bf64ebfb9ed078550bb603908abcc4e52" => :el_capitan
    sha256 "d768aaf1debc3c88bd8aed92ada1ded1dea87be9f579c54a39bd0c6a33bcf9ac" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Intl < AbstractPhp55Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    sha256 "7a0d3ecedf27ab80fd5b5f62b7de6bb9b8397adb76f0ae173b7af3fe492759d9" => :el_capitan
    sha256 "35bbdf90aa2b19ba1740a302e9af4f09109805b91b6bb05ad8999418fd73ab4d" => :yosemite
    sha256 "7fb398d4c3afcbf4978ac29177770a1202c3a59790f4c22e700af8e60052a6f4" => :mavericks
  end

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





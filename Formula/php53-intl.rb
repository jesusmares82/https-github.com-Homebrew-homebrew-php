require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Intl < AbstractPhp53Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "26683df2d453e0518b26fa5bae01a45c3ab7255dd45b910653ee1c0d6103383e" => :sierra
    sha256 "4b38a186b09874a39dc14247859cb128dc141caf191dca0cbfc1e981fb8d9ccd" => :el_capitan
    sha256 "79f69188864b93e5654c7fc41a14c61142062641eaec71544bb195380c8e49a3" => :yosemite
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

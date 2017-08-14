require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Intl < AbstractPhp53Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "cfad7efe986e403e621a730f01be9c8e9b0d76a12f32dfc7922ffecc7fc89752" => :sierra
    sha256 "a39d340dd5472c88e7e298a8356ea0517fffc6218ae8a91cdfcf2e2c8a58a1ac" => :el_capitan
    sha256 "94fc2587958e6b2f03d19b870738886f5367e3694835e6180ef6fb9bea085a76" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    sha256 "07578bbbdb7998a5afb5b4d2484c83ebf015d30b89ad63895fedafd0c7ecf12c" => :el_capitan
    sha256 "d168a58f649bbda8bfa71c8a35336aea26d0cf63f7740cf546162777dec26f10" => :yosemite
    sha256 "b4ad4d445bd831d22624189c1c1737911f8843e0e5b56b3555e9943e0e0a24e7" => :mavericks
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

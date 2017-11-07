require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"

  bottle do
    sha256 "a2490a3977270ab599278badb92ea47577fd3591ed9bdee290ea880cb65006eb" => :high_sierra
    sha256 "b69ab7d29fd345097de48f01b822426cac9def5d325e8b7793cbf19326f0bd1c" => :sierra
    sha256 "86719b73d856a3ba3e243150ebbf5cdf164e9d2fa0db8d98e42811347e35ef32" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 6

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

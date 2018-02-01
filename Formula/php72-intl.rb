require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"

  bottle do
    sha256 "807b31ded9533233a29afb69c6d20b4aa348af5a768232e71a28271ebdaad9f6" => :high_sierra
    sha256 "d3c092035834a77cfd1b5cdfa59edb79e66b5158bad3bea718aad1380dd63f25" => :sierra
    sha256 "b2531e4648676ecc03fefa1699489a8b0e31db3cd3ab20702ea9c5b529dda57a" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 11

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
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end

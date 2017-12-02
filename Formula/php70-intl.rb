require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 21

  bottle do
    sha256 "d996b21766f5d84149b5d0e83b7f0f27e6bb2dcd78e59cdba6d79f20e7760a95" => :high_sierra
    sha256 "b191f6f9fb4fcd7a5b5c6e2bc0c0624fcc24b1fde124ef041814e2e88209616b" => :sierra
    sha256 "a799131d0b6c0e276ef516ee1d5dbf19f3a3b8cd5476d583e7804fba48435481" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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

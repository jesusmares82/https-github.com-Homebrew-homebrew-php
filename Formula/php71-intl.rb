require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 24

  bottle do
    sha256 "041b7c6eb98bf79aa23e9cc4336b4566ccd8ef290587cdcc766c6bd3db26eccb" => :high_sierra
    sha256 "bcced7dbe80663aef8da593ec2362c7abdd8733fa5b9027d4bab64002acdb3ab" => :sierra
    sha256 "56909c22835f51cabb269d281d513960ac739bfb3a79f4738422957e9a873022" => :el_capitan
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

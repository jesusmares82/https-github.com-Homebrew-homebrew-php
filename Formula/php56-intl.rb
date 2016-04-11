require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    sha256 "08f3b966d49bc039e674127a778bb0c8f05082c3d8e773c76954af289347a8e5" => :el_capitan
    sha256 "11da8b197e7773e7e6d20c9d5305d044c51d2876ead2fa0e5688f72857c51c57" => :yosemite
    sha256 "871257edda772617277c5053f86e1d4253d0a28d26868f91e9772f3886c393e5" => :mavericks
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





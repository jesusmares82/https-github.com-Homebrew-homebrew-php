require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Intl < AbstractPhp53Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    sha256 "f1d57c0a55472bcfe6fc1ec2ba5c9582d10d91e2b955c8ddaab723441833a13e" => :el_capitan
    sha256 "b0b1300d845b3bef8c19e3449dc20d695ee82c450d8052ae5ab76d18e2538439" => :yosemite
    sha256 "139a0f834ca7a8e30c514ddd60b04af1c57a5f7db2f788b9f0b808ab24197d57" => :mavericks
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

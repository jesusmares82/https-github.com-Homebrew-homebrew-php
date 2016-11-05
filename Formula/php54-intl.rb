require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "a28f97010642d0cf384da196181c89895248fd16ac4c2052dbf88e2a2034f270" => :sierra
    sha256 "987a774e29d3046ca19e1244d0e56ca39915007eea7b47f6bb37335c7fdf23cb" => :el_capitan
    sha256 "ca1c07ca4c24325f5aa9c93d0f24574636d1482420b4560d23e930758f5aad95" => :yosemite
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

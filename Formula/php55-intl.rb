require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Intl < AbstractPhp55Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "c0e670a2dbd922653b347ea5f65b2df88a90eb0677f6c2444d4541b1228c12d7" => :el_capitan
    sha256 "3a68cc6d3964b4d43272e5329a3b3365138cae0e5f37f1a6378833c8b9bd452f" => :yosemite
    sha256 "03fa91c5e5a4dc7f39b11f124122ede3c0aa6ce74c0cc6d8508e34d1c3d24551" => :mavericks
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



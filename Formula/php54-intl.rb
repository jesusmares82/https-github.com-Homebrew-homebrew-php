require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "48976c4c5b4e3b4185fa164323763bbbf381319edf8ff3c40dbb11ec04ba96cd" => :yosemite
    sha256 "0541cea5f982fa4c47ce9d2c41a68d92d82709b2d4d8f825b59e560d77782b22" => :mavericks
    sha256 "d5c5994b446174cd29c54a3e689bd96ce18098df97f321130b558acd1b6f047e" => :mountain_lion
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

  test do
    shell_output("php -m").include?("intl")
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.intl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "91794058e556d1f531032949cf4848e2eb76cb64d4a342e4a964d97fbc833cef" => :yosemite
    sha256 "5e4fba547b4ee1fea7e37107a5836d11970bf4013c403ba358005e0a969873cf" => :mavericks
    sha256 "a7d5fece3ce4d8ae4638d8dd24c4745ea8d6e0d43056c32d0cf2c869eddeb2c2" => :mountain_lion
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
                          "--with-icu-dir=#{Formula['icu4c'].prefix}"
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

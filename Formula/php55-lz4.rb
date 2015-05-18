require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Lz4 < AbstractPhp55Extension
  init
  homepage 'https://code.google.com/p/lz4/'
  url 'https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz'
  sha256 '9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end

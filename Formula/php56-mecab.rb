require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mecab < AbstractPhp56Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "451f38aaff878f71881c0e4f03861a2dc6f4082cb3c908e55611057da6cb47fd" => :el_capitan
    sha256 "ca149643bea494e2791b940cb1637e6019ae5591e44786a850537333b1abf243" => :yosemite
    sha256 "6eddc9b81c27f6b4c05de5caf9d7121070e519b41d1e65e38b29df58e5ab9326" => :mavericks
  end

  depends_on "mecab"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-mecab=#{HOMEBREW_PREFIX}/opt/mecab",
                          phpconfig
    system "make"
    prefix.install "modules/mecab.so"
    write_config_file if build.with? "config-file"
  end
end

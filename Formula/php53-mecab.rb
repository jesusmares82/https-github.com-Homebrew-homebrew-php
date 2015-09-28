require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mecab < AbstractPhp53Extension
  init
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "cd1ce73cf46aff4ce04ed1b2271bb73c4246f000af526880dc66747e5cc21418" => :el_capitan
    sha256 "b95f205c7df1b4b308dfde27527c36bff4e3cbc9f46cae2793b83c6e9789a5d4" => :yosemite
    sha256 "7bcbfa357ab1c3969ba5e87a165f3ff23b0cc8f228b33ec6e0eac5cf218c32ed" => :mavericks
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

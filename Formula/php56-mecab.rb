require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mecab < AbstractPhp56Extension
  init
  homepage 'https://github.com/rsky/php-mecab'
  url 'https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz'
  sha1 '3f451e67f736b8d4a8b494cb0333cfbb5fa4a274'
  head 'https://github.com/rsky/php-mecab.git'

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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Lz4 < AbstractPhp54Extension
  init
  homepage 'https://code.google.com/p/lz4/'
  url 'https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz'
  sha256 '9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "efbd38fae314bebec3ce4429e8df06f20592944c4a939bce3eefac8f1726e639" => :yosemite
    sha256 "3a738d5b75724dbb58171db74ac1d03a526a2e3773c6a3810d8850a7139de0fd" => :mavericks
    sha256 "489121a2db16e29944b7b456d0bccb6af60017cfd8719cc0340d7768af78d8ca" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end

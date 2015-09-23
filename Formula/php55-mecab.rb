require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mecab < AbstractPhp55Extension
  init
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "c74261246fe506e07474962951520a2109f25ce5e91821399b58f9922ff18a07" => :el_capitan
    sha256 "8560ff34263f8d3ab4cad0b7795c09ec0404514de453c7ef2b77119b9ed7a305" => :yosemite
    sha256 "de9a8ca52e544891286e132f11efec686ea4deb9194d25b206053ed2702607f3" => :mavericks
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

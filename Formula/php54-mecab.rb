require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mecab < AbstractPhp54Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/downloads/rsky/php-mecab/php-mecab-0.5.0.tgz"
  sha256 "e5c84a8ffa39a8a0dd60424b879806382ec0f66d50007f6bfad6831074b3bcc5"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "e6702e9e6b31fcb2e67a0802d9a5a819d0e25388383123361f79c1e6f3fbbc08" => :el_capitan
    sha256 "fb23ec03f4fe3e1b207bee8a1b7032d452351164853aeef6feadaad210259206" => :yosemite
    sha256 "ac8af2fd6b065f7239789f3e2d95a345695491015403990a7cc7f0bd5fb6e812" => :mavericks
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

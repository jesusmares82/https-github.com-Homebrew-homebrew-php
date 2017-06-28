require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mecab < AbstractPhp72Extension
  init
  desc "MeCab binding for PHP"
  homepage "https://github.com/rsky/php-mecab"
  url "https://github.com/rsky/php-mecab/archive/v0.6.0.tar.gz"
  sha256 "8ec57164dd208f700ca16853f07fb62f111e16b025ca1ab5d4100aaaa9aa7c58"
  head "https://github.com/rsky/php-mecab.git"

  bottle do
    sha256 "84d69df11d7a27aebf624e920a40bdcf950d956efaad244d6acf8b4c853ea65b" => :sierra
    sha256 "2e0d1241babed6f7d2bb881036ceaf077cf26740c8f2c2e11b0e719deb812b57" => :el_capitan
    sha256 "26f103497315ae6436be7dc7fd020633950bb3e378bca890b9bed00c0eeff357" => :yosemite
  end

  depends_on "mecab"

  def install
    Dir.chdir "mecab"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-mecab=#{HOMEBREW_PREFIX}/opt/mecab",
                          phpconfig
    system "make"
    prefix.install "modules/mecab.so"
    write_config_file if build.with? "config-file"
  end
end

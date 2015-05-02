require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Sodium < AbstractPhp53Extension
  init
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.0.7.tar.gz"
  sha256 "07d06b486ab5b687e63109d64bf9fd21c846a315b8c71088639dfa0a7272339e"
  head "https://github.com/alethia7/php-sodium.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "2c77bea3696d535a61f1c01243bf4f358de023c6548a305d27c8fd876881a3cc" => :yosemite
    sha256 "93d9fa0ff25b03a0cbb6e64886226b948788f300f64ce08850c3a4552f6c11f8" => :mavericks
    sha256 "467810dd6da9d35d64e4748c9f4f97a99261a6a9fe3e8579c2ff522aa2b4f1de" => :mountain_lion
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").split("\n").include?("sodium")
  end
end

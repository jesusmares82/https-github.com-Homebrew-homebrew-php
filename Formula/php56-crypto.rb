require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Crypto < AbstractPhp56Extension
  init
  desc "Wrapper for OpenSSL Crypto Library"
  homepage "https://pecl.php.net/package/crypto"
  url "https://pecl.php.net/get/crypto-0.1.1.tgz"
  sha256 "9844e93078ac165255bdba6944abf6ec196be9964f9807df9f8f7d792a18807b"
  head "https://github.com/bukka/php-crypto.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9effad0b6888e9574739b123d2b129c776822fcd0dd3524cb113070c9e4e717a" => :el_capitan
    sha256 "a95a0e018cc0ff7327e17711d9e0a13046799b390bf80609894ca72e9c209dbf" => :yosemite
    sha256 "a470cf9f52c88dc402c2a76aa594851bf3b9f777ff5e836de85b5d0b77d52fa9" => :mavericks
  end

  def install
    Dir.chdir "crypto-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-crypto"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/crypto.so"
    write_config_file if build.with? "config-file"
  end
end

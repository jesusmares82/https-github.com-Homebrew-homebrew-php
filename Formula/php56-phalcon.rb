require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.2.tar.gz"
  sha256 "ed1d4cfa15c6bb2b0c80cbf63ad8e06fd8517e48413a7dc95c445409be350c84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "05b6b8c373589de5e500ea35d9596abf11e672dad209ec024ae492eb5f551b3a" => :yosemite
    sha256 "a542fc3ae3d02da7cd2bab059a4bb7e00b5dc712beec1e1280b6d7361846e7e9" => :mavericks
    sha256 "dbb0e764336088f7f0e6a6268e5ffed100ab8d02071ac33132c98396b306f2f3" => :mountain_lion
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end

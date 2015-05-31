require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.2.tar.gz"
  sha256 "ed1d4cfa15c6bb2b0c80cbf63ad8e06fd8517e48413a7dc95c445409be350c84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "063c9be7fa41787d37b39f5a1726f9775acdf71d5d9fe4dd283bff8497c7e5f6" => :yosemite
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

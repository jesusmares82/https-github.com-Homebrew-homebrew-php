require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.2.tar.gz"
  sha256 "ed1d4cfa15c6bb2b0c80cbf63ad8e06fd8517e48413a7dc95c445409be350c84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f12d0a6abb029a060be0a0a835723c2c048b79b44c662701897a01c0ed0a4c94" => :yosemite
    sha256 "46846d1e715e6b9540b1923385bfb28e7202659623ddbe1c67b084ad3a539ffd" => :mavericks
    sha256 "7d4f0b1c4025b879a2ea4f60d59cbf4c0cd799130ed7c3b22c0fe14a1da86a9e" => :mountain_lion
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Lz4 < AbstractPhp71Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.3.tar.gz"
  sha256 "f484c8229b3c5af1385ce11e4b37999702757bad9bdb2eab8bfe48fa3f159904"
  head "https://github.com/kjdev/php-ext-lz4.git"

  bottle do
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71LibsodiumAT10 < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.7.tar.gz"
  sha256 "b66c795fa39909eccbc4310e6e9700230e5ad9e8e9d7fcf79bb344dbf9d2f905"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "74d31706bb4daeb74f619b149f686334e7317cfa7e8530e50fbd42697873ff77" => :high_sierra
    sha256 "2aed03ae0d8970032147356a577f68809cc28d8ac3500f19f1ad451a10ebfa17" => :sierra
    sha256 "7289833eefccf59bad857d2db7d7e74489c2d37ebd39812f7ec2cbb767ddb2bc" => :el_capitan
  end

  depends_on "libsodium"

  def extension
    "libsodium"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end

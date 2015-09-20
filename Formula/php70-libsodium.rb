require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Libsodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.0.tar.gz"
  sha256 "780b2a3424ad5a489df48021bb7f422f828b86cc2d5619de8bb5b63b1a3636f9"
  head "https://github.com/jedisct1/libsodium-php.git"

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("libsodium")
  end
end

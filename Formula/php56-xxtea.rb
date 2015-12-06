require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xxtea < AbstractPhp56Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.10.tgz"
  sha256 "2735d2bc28c3ecdaa12491252f71c357c25c461d0a5802377218489807a801d8"
  head "https://github.com/xxtea/xxtea-pecl.git"

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end

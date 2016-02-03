require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xxtea < AbstractPhp56Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
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

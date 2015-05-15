require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Raphf < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/raphf"
  url "http://pecl.php.net/get/raphf-1.0.4.tgz"
  sha256 "461be283e89d94186a3ed4651b92c7c1a067bad7b6476d0ca7ac8863dc1ed8bf"

  bottle do
  end

  def install
    Dir.chdir "raphf-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install "php_raphf.h"
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("raphf")
  end
end

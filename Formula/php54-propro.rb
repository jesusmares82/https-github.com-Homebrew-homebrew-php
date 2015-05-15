require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Propro < AbstractPhp54Extension
  init
  homepage "http://pecl.php.net/package/propro"
  url "http://pecl.php.net/get/propro-1.0.0.tgz"
  sha256 "9825d50ab4bb214428cd11c14c2f389c16aded09db16d266f27f147a7f2371f2"

  head "https://git.php.net/repository/pecl/php/propro.git"

  bottle do
  end

  def install
    Dir.chdir "propro-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w(php_propro.h)
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("propro")
  end
end

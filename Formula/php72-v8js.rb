require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72V8js < AbstractPhp72Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.1.tgz"
  sha256 "38a16ae4381eb36695cb2f4cce802124242c279cfbd7640d256aff57d260ad4c"
  head "https://github.com/phpv8/v8js.git"

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end

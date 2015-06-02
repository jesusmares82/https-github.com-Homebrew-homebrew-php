require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Hprose < AbstractPhp53Extension
  init
  homepage "http://pecl.php.net/package/hprose"
  url "http://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("hprose")
  end
end

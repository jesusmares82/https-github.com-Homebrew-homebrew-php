require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Hprose < AbstractPhp55Extension
  init
  homepage "http://pecl.php.net/package/hprose"
  url "http://pecl.php.net/get/hprose-1.5.2.tgz"
  sha256 "9496d07d49dbae73677b076f6ff0ee4cf1bff861ac981eef76975b4aa9657623"
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

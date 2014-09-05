require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Vld < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/vld'
  url 'http://pecl.php.net/get/vld-0.12.0.tgz'
  sha1 'c4006aeed9fd8190501f6b5d6c20315259f2795a'
  head 'https://github.com/derickr/vld.git'

  def install
    Dir.chdir "vld-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/vld.so"
    write_config_file if build.with? "config-file"
  end
end

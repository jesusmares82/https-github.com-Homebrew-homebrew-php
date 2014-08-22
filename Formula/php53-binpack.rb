require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Binpack < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/binpack'
  url 'http://pecl.php.net/get/binpack-1.0.1.tgz'
  sha1 '0b7c83681fe3ed9f8a3259e07f0904ba566d0c19'
  head 'http://binpack.liaohuqiu.net'

  def install
    Dir.chdir "binpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/binpack.so"
    write_config_file if build.with? "config-file"
  end
end

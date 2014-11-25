require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pthreads < AbstractPhp56Extension
  init ['with-thread-safety']
  homepage 'http://pecl.php.net/package/pthreads'
  url 'http://pecl.php.net/get/pthreads-2.0.10.tgz'
  sha1 'be2745b65ecf09190fb323ccbf168288c70cfd6c'
  head 'https://github.com/krakjoe/pthreads.git'

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end

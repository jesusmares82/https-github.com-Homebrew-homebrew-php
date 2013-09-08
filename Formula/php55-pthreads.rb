require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Pthreads < AbstractPhp55Extension
  init ['with-thread-safety']
  homepage 'http://pecl.php.net/package/pthreads'
  url 'http://pecl.php.net/get/pthreads-0.0.45.tgz'
  sha1 '16335470385f57483bc420b2a3e0a6eb87c06042'
  head 'https://github.com/krakjoe/pthreads.git'

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file unless build.include? "without-config-file"
  end
end

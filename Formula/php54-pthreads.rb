require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Pthreads < AbstractPhp54Extension
  init ['with-thread-safety']
  homepage 'http://pecl.php.net/package/pthreads'
  url 'http://pecl.php.net/get/pthreads-0.0.44.tgz'
  sha1 'aef4e5e8dd6278f3cb3f997975406401cbce097f'
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

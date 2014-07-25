require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pthreads < AbstractPhp54Extension
  init ['with-thread-safety']
  homepage 'http://pecl.php.net/package/pthreads'
  url 'http://pecl.php.net/get/pthreads-0.1.0.tgz'
  sha1 '311837ce19a76983d5d7af7d13af4e3528f4a70f'
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

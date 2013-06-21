require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Pthreads < AbstractPhp55Extension
  init ['with-thread-safety']
  homepage 'http://pecl.php.net/package/pthreads'
  url 'http://pecl.php.net/get/pthreads-0.0.42.tgz'
  sha1 '86a16b5a9e5ff646368a9f449a206eb313c8eaa4'
  head 'https://github.com/krakjoe/pthreads.git'
  version '0.0.42'

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

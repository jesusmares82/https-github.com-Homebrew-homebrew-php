require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pthreads < AbstractPhp56Extension
  init ['with-thread-safety']
  homepage 'https://pecl.php.net/package/pthreads'
  url 'https://pecl.php.net/get/pthreads-2.0.10.tgz'
  sha256 '8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6'
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

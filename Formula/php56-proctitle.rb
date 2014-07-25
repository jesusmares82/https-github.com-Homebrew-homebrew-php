require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Proctitle < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/proctitle'
  url 'http://pecl.php.net/get/proctitle-0.1.2.tgz'
  sha1 '9fe4e5a807d83fa15bdb59fac16189103b2dd398'
  head 'https://github.com/MagicalTux/proctitle.git'

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w(modules/proctitle.so)
    write_config_file if build.with? "config-file"
  end
end

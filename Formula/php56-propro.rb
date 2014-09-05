require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Propro < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/propro'
  url 'http://pecl.php.net/get/propro-1.0.0.tgz'
  sha1 'f2cbcbc322e88fda55b2fc8908426106e2f18db4'

  def install
    Dir.chdir "propro-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w(php_propro.h)
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end

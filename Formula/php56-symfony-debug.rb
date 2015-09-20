require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56SymfonyDebug < AbstractPhp56Extension
  init
  homepage 'http://symfony.com/'
  url 'https://github.com/symfony/Debug/archive/v2.6.0.tar.gz'
  sha256 '00bfc3c279ee1fd10eb8f771e4a3cca988cf4eb0f1bda88fcd595e5149f32a28'
  head 'https://github.com/symfony/Debug.git'

  def extension
    "symfony_debug"
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir 'Resources/ext' do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
             phpconfig
      system "make"
      prefix.install %w(modules/symfony_debug.so)
    end
    write_config_file if build.with? "config-file"
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54SymfonyDebug < AbstractPhp54Extension
  init
  homepage "http://symfony.com/"
  url "https://github.com/symfony/Debug/archive/v2.6.0.tar.gz"
  sha1 "ea9aa9791acb62dd2e87d90e1bf3499e70483b89"
  head "https://github.com/symfony/Debug.git"

  def extension
    "symfony_debug"
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "Resources/ext" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
             phpconfig
      system "make"
      prefix.install %w[modules/symfony_debug.so]
    end
    write_config_file if build.with? "config-file"
  end
end

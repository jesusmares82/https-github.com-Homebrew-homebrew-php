require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54SymfonyDebug < AbstractPhp54Extension
  init
  desc "Symfony debug component"
  homepage "http://symfony.com/doc/current/components/debug"
  url "https://github.com/symfony/debug/archive/v2.7.5.tar.gz"
  sha256 "60e9e5e84d01a80c3028bde183eeaf1adb85cdd0761a23076dc3852e84afa52e"
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

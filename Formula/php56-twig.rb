require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Twig < AbstractPhp56Extension
  init
  homepage 'http://twig.sensiolabs.org/'
  url 'https://github.com/fabpot/Twig/archive/v1.16.0.tar.gz'
  sha1 '078d346665f30c32d0c33e19c8e8075b7955d156'
  head 'https://github.com/fabpot/Twig.git'

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir 'ext/twig' do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w(modules/twig.so)
    end
    write_config_file if build.with? "config-file"
  end
end

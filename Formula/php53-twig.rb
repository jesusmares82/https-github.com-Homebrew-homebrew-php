require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Twig < AbstractPhp53Extension
  init
  homepage 'http://twig.sensiolabs.org/'
  url 'https://github.com/twigphp/Twig/archive/v1.16.2.tar.gz'
  sha1 '926ff53dad6ccd2560a562942d1dfd1357460cc0'
  head 'https://github.com/twigphp/Twig.git'

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

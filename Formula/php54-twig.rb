require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Twig < AbstractPhp54Extension
  init
  desc "flexible, fast, and secure template language"
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.23.1.tar.gz"
  sha256 "f8643b21ba3b1ad21593567bddbab0ecba07449a7185032ce29fee4249e797f0"
  head "https://github.com/twigphp/Twig.git"

  bottle do
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/twig" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/twig.so]
    end
    write_config_file if build.with? "config-file"
  end
end

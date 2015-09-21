require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pimple < AbstractPhp53Extension
  init
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha1 "4ded64814812e3ec2f955b76cdcfab99831d7318"
  head "https://github.com/silexphp/Pimple.git"

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/pimple" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/pimple.so]
    end
    write_config_file if build.with? "config-file"
  end
end

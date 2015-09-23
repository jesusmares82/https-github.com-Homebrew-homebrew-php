require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pimple < AbstractPhp55Extension
  init
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f3866e8b146fd60504a5fae80b33b654d2e54d692421b19bd7e2bd8166f1eab4" => :el_capitan
    sha256 "27d3658c91e7084488f173b52343172231270524a8c372d108d07ce134e8f5b1" => :yosemite
    sha256 "be24f3297d12ac4f86355ea68996507716d18925958530b48f4b86ed56513214" => :mavericks
  end

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

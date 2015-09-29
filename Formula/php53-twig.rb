require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Twig < AbstractPhp53Extension
  init
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.16.2.tar.gz"
  sha256 "891e0e8f8eeee10f67c84556c28258dc5a96f8ef83e9fee1fefa64cf6aee27ef"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ed521cd7697893537b0fc8cc3a62c6edef1611370bb121db65457ea4d82ef49e" => :el_capitan
    sha256 "2a7b5877b9cd9e9097d0cc7ee1e55ecabec6e4a05d3141323f650ceaaaf770f8" => :yosemite
    sha256 "a4da130bbb7460350b44153eccf2aab69a8cd75fa74f23bc3fdf84a646b88921" => :mavericks
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

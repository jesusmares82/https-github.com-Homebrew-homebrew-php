require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Twig < AbstractPhp54Extension
  init
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.16.2.tar.gz"
  sha256 "891e0e8f8eeee10f67c84556c28258dc5a96f8ef83e9fee1fefa64cf6aee27ef"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "37fe8f939129e905ba7477313c392968969ea85d3db15b82baf7cbf473a165b4" => :el_capitan
    sha256 "2a75264d4c9416728a55f49b25df0bb1aa1702de39d880d1a68d31d734d3837f" => :yosemite
    sha256 "bbd356c21468cac8a8fea154030e290df742f569bd21af7f04fdc8299c4f9a64" => :mavericks
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

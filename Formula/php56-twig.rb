require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Twig < AbstractPhp56Extension
  init
  homepage "http://twig.sensiolabs.org/"
  url "https://github.com/twigphp/Twig/archive/v1.16.2.tar.gz"
  sha256 "891e0e8f8eeee10f67c84556c28258dc5a96f8ef83e9fee1fefa64cf6aee27ef"
  head "https://github.com/twigphp/Twig.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2ed06c568ceb0691c6a99a1724442c24ad3cb1874d42f4ab6321d5aa7c42c856" => :el_capitan
    sha256 "4a39ae7eda88a50f755c4bf88e6e152f9a10d25a62fdea33783f3792e0a5e771" => :yosemite
    sha256 "4180967ca0760b352b5a88967f280c2ac7fc584932ff776e580034d04526fe98" => :mavericks
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

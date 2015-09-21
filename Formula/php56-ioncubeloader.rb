require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
    sha256 "fca36c0c00d640d3fa45d3862c68dcc5b3d33afffbc5c902bdc9725df2d1e035"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
    sha256 "9a3cd4ddad2dad23aa87e49a28ea1fa98878d11a5e7bbfa04fc4d1da6874b4c1"
  end
  version "5.0.17"

  bottle do
    cellar :any_skip_relocation
    sha256 "6ece524308f733d7192a0bbe2882300bceaef8a86c87b0ebac8092ab3f95eefc" => :el_capitan
    sha256 "b78c50912308ede83ce9a7bfe0365792279603aa0b93fc371079d7f36c6485f3" => :yosemite
    sha256 "aa4f9810644c7c252a6b5ecceaa8f758fcf220fc6d6785b1118d79e95f7505de" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.6.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

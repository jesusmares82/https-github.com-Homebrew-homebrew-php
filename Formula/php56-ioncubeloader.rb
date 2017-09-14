require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "af0b548d0e27e6fea9f0b5ee73b2c2099e1cd67f6dd9fd74d2e718ff151d994f"
  version "10.0.3"

  bottle do
    cellar :any_skip_relocation
    sha256 "fbdbbe0ac5918ce2fbea5ad2b6eb30466e9009d05bf14305cd6337f728dd8278" => :sierra
    sha256 "8f65aab3ba56d4a605b48214c05639950de8619f4ef8cd3151ea0b3ca230a464" => :el_capitan
    sha256 "d0ecfe2fb768b0334d003c7a722783eb3af8732d7b748bea4e8de017dccbcb58" => :yosemite
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

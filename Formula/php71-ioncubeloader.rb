require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ioncubeloader < AbstractPhp71Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "af0b548d0e27e6fea9f0b5ee73b2c2099e1cd67f6dd9fd74d2e718ff151d994f"
  version "10.0.3"

  bottle do
    cellar :any_skip_relocation
    sha256 "95a4ad96914a70a88347b2a0a84fa2b9e09d463ef2144fc9b2f4a6748cedb456" => :sierra
    sha256 "95a4ad96914a70a88347b2a0a84fa2b9e09d463ef2144fc9b2f4a6748cedb456" => :el_capitan
    sha256 "9d614d6e357fe2a4316d105ec8bda1ed3132d6aef36fc2c6b04b8e9d31f2f592" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_7.1.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

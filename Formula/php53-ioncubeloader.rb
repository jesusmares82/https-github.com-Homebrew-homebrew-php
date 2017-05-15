require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Ioncubeloader < AbstractPhp53Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "1c9b17a4750578299277cc69631769ecc63708da0b12253cb333434add10332a"
  version "6.0.9"

  bottle do
    cellar :any_skip_relocation
    sha256 "997f966fa75264ba92dcca40b27ac14e3efba927b48fbc84a62e12f964f4315f" => :el_capitan
    sha256 "b2976f047825b83eb2ff0c55849fb87c048f282f5d87f8358843c365d9c80ae3" => :yosemite
    sha256 "55ebd896f52b6ea7ecb061984010851a41febd6bd694a9d4be4af391b2f4fd40" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.3.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ioncubeloader < AbstractPhp70Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
    sha256 "808b6bf93662f96579ad4ce9b6d4c999d98e6e543f9630b45a2b31c2907127d5"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
    sha256 "0586f13ac48e383309b7d56bb5ae7b4ee9872d012b6b9b78b273f1de780c4123"
  end
  version "6.0.6"

  bottle do
    cellar :any_skip_relocation
    sha256 "e56e9dad7f164f520d038c42b2ac820a82ee405297b59b316a966bb4739e401d" => :sierra
    sha256 "e56e9dad7f164f520d038c42b2ac820a82ee405297b59b316a966bb4739e401d" => :el_capitan
    sha256 "530cafd2cf4b29f19e7de7cf7ab9d23ce0ae70e189293b704766da29947e74b1" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_7.0.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
    sha256 "e3649def6e14f8d6aad08326e6579a7b7e660e3eca65c240755f759b3920efa8"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
    sha256 "96a0e211971352acb843718565c371938881da7d77dd8bca7519466f06dfdda2"
  end
  version "6.0.5"

  bottle do
    cellar :any_skip_relocation
    sha256 "636c5b1711308dfb6d3c33517ebf1e52f6c946352609aec6273d7d292c7064d7" => :sierra
    sha256 "636c5b1711308dfb6d3c33517ebf1e52f6c946352609aec6273d7d292c7064d7" => :el_capitan
    sha256 "57cba19e8393391a4f72f72d3f107839cd5c2b4813079a2f26562e739f8d3962" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ioncubeloader < AbstractPhp70Extension
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

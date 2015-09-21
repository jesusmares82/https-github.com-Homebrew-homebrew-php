require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ioncubeloader < AbstractPhp55Extension
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
    sha256 "c5a234b888feced28f98c1a840bb98694b83e049b099dd36b8beccfad93bb855" => :el_capitan
    sha256 "51f43c5f2c10bf978d166327819dfb984f1d2421bb66ff67a50d316f47da24d2" => :yosemite
    sha256 "2cfb9b413b15c7b145eef3a1ce7479d3f65a7c5163a0efb42533977664079a5a" => :mavericks
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

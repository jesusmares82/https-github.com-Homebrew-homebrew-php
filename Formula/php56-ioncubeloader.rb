require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
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
    sha256 "894b6c361c9ff84bb0008c2a93dee28e39ee96642c81fdbaf8e060e79ddf023b" => :sierra
    sha256 "894b6c361c9ff84bb0008c2a93dee28e39ee96642c81fdbaf8e060e79ddf023b" => :el_capitan
    sha256 "6b742bba0f283636f16914e00e2bb2756158a4ca5e71824794f657f75d0daf56" => :yosemite
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

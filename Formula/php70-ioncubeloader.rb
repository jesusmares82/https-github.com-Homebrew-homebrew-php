require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ioncubeloader < AbstractPhp70Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
    sha256 "267f9c4810eec91420f338e3206c1fce02e4ee85e1c491a7234707ab7fb200f5"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
    sha256 "1413fd42c03eabfcae3b37ebbbf1fbe08d89b865c07dc166231ef1fda26fe2aa"
  end
  version "6.0.8"

  bottle do
    cellar :any_skip_relocation
    sha256 "f85714ecd0c1e3f0b4dec8847b526a15dd58259ad17393a3fa792c8722f202b4" => :sierra
    sha256 "f85714ecd0c1e3f0b4dec8847b526a15dd58259ad17393a3fa792c8722f202b4" => :el_capitan
    sha256 "6ad778b4ea3a4def049f1000ed612c9c01ab05b8505117b012f62725493997a2" => :yosemite
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

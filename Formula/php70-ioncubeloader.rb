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
    sha256 "0812686868ee6b6c3c6830fc1119f564288633176f15a6656d60b27390df05d5" => :sierra
    sha256 "aff67fad9184b78d6da81cb2b57e54ee47556e00a8d764066d296849d3dcf2c1" => :el_capitan
    sha256 "85b593a218bf6c15089f77628ad6b0a628501e431838e76d2d8ab4cde567f5cb" => :yosemite
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

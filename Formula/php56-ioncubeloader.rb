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
    sha256 "34664036031ef186d8148d237fa41516a391a218367fd4966fab93ebc6801f88" => :high_sierra
    sha256 "34664036031ef186d8148d237fa41516a391a218367fd4966fab93ebc6801f88" => :sierra
    sha256 "34664036031ef186d8148d237fa41516a391a218367fd4966fab93ebc6801f88" => :el_capitan
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

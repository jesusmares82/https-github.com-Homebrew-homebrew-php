require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
  init
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
  end
  version "4.7.5"

  bottle do
    sha1 "1afa94ee86d9bb533d28d0cc94788dff6f14c15b" => :yosemite
    sha1 "45b8eb3729394694dbecb94a8866b64c21dded6a" => :mavericks
    sha1 "da195600da8f73ea5503b35a0e1ec1015e58ef06" => :mountain_lion
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

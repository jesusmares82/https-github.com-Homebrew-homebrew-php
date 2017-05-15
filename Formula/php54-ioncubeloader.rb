require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ioncubeloader < AbstractPhp54Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "http://www.ioncube.com/loaders.php"
  url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "1c9b17a4750578299277cc69631769ecc63708da0b12253cb333434add10332a"
  version "6.0.9"

  bottle do
    cellar :any_skip_relocation
    sha256 "555758eb7e10ce3476639ffc925619225488adfde374c2afe805368324181b9c" => :el_capitan
    sha256 "459c902281fa714db00ff8d47b6bca385a437d36b2496c2adb9a8a2799cf30ac" => :yosemite
    sha256 "fe13976544be8f340f89e09f3703307358e8baaf35bac9a337fd06ab49ff3f84" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.4.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

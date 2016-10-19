require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
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
    sha256 "bd1518bf72f21ee40b0571f6197e7d728d7db6d279aaa18b6cbda16cc21acfe7" => :sierra
    sha256 "bd1518bf72f21ee40b0571f6197e7d728d7db6d279aaa18b6cbda16cc21acfe7" => :el_capitan
    sha256 "b84c247b7de18dbc527b15ff515f3ab4371075530799078a22568a49c22c915c" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Ioncubeloader < AbstractPhp53Extension
  init
  homepage "http://www.ioncube.com/loaders.php"
  if MacOS.prefer_64_bit?
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  else
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
  end
  version "4.7.5"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "0347a0ae2bb6b568bb168439fdfe32df42b730d0" => :yosemite
    sha1 "71151bd7f43f846c08d096b46fdfd76f293a7426" => :mavericks
    sha1 "48e37a66e69248948ddb032e8e507d5056088283" => :mountain_lion
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "ioncube_loader_dar_5.3.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

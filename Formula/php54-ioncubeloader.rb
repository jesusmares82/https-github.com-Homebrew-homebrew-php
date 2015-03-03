require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ioncubeloader < AbstractPhp54Extension
  init
  homepage "http://www.ioncube.com/loaders.php"
  if Hardware.is_64_bit?
    version "4.7.5"
  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "0b98bf9f06ed18ba2ed732ef6b5754c208dbe68a" => :yosemite
    sha1 "2ba11dbf011cba849cb1a502dcffc748f40ef396" => :mavericks
    sha1 "e1b6b6c88e40cb01dcec63fe8216183d8d1a401b" => :mountain_lion
  end

    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  else
    version "4.7.5"
    url "http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz"
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

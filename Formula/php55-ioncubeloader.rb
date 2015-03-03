require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  homepage "http://www.ioncube.com/loaders.php"
  if Hardware.is_64_bit?
    version "4.7.5"
  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "858e409c505befb12c20999fd6a854ac2f6fa281" => :yosemite
    sha1 "2f415dd2a6b0c899f547d179378e1cb05eb39cdd" => :mavericks
    sha1 "0eb9efc17100409121c62b2d29ac8188a2513538" => :mountain_lion
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
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end

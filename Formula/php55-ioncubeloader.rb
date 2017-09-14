require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz"
  sha256 "af0b548d0e27e6fea9f0b5ee73b2c2099e1cd67f6dd9fd74d2e718ff151d994f"
  version "10.0.3"

  bottle do
    cellar :any_skip_relocation
    sha256 "dbe57e3b95d21f3a6ba1aef4110a7ba09f3ef9dfa6b3e8b000f023dec694659e" => :sierra
    sha256 "06595e8995a94b56c965dbd93d90b1f5d218e511a957ad1b045341e3f785747c" => :el_capitan
    sha256 "a48aad687f50b131efd230c6f8a3162e42b610c91e20bffb6d7b02edad415b91" => :yosemite
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

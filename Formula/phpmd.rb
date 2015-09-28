require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.2.3/phpmd.phar"
  sha256 "5cd9d4754a0d2c41a403afe6b7b75e6994d90f8e8df3600a200398dd4271a31b"
  head "https://github.com/phpmd/phpmd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "35e7188f625ba25bdae97569bf89225146c142fb831838b45020b1b288400216" => :el_capitan
    sha256 "8431a91345f2b4ee6b23235ddac64b9ee955737caf5dee7d796ff33093cba13f" => :yosemite
    sha256 "8431a91345f2b4ee6b23235ddac64b9ee955737caf5dee7d796ff33093cba13f" => :mavericks
  end

  test do
    system "phpmd", "--version"
  end
end

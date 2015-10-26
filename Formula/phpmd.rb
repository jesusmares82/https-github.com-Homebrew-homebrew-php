require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.3.2/phpmd.phar"
  sha256 "81b2c8cfc45c4190e504a25a5c207a5eb5c85e0f0809b2620e2440bfef3edd7c"
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

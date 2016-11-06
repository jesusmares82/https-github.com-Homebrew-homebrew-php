require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Behat < AbstractPhpPhar
  init
  desc "behavior-driven development framework"
  homepage "http://behat.org/"
  url "https://github.com/Behat/Behat/releases/download/v3.2.2/behat.phar"
  version "3.2.2"
  sha256 "c350953b14e00f0db97e24e49e68ffbffab809ec19bdf40c398fe6645e2d6acd"

  bottle do
    cellar :any_skip_relocation
    sha256 "3fb24c053ede48c5adf6417fd62d3a1403004dbac28a71d3042fad73eee7bd2b" => :sierra
    sha256 "3fb24c053ede48c5adf6417fd62d3a1403004dbac28a71d3042fad73eee7bd2b" => :el_capitan
    sha256 "3fb24c053ede48c5adf6417fd62d3a1403004dbac28a71d3042fad73eee7bd2b" => :yosemite
  end

  test do
    system bin/"behat", "--version"
  end
end

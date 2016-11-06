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
    sha256 "ff7a30ffd16033128d31712097200925c4391e6aebf86f5bf1c5deedc610f020" => :sierra
    sha256 "ff7a30ffd16033128d31712097200925c4391e6aebf86f5bf1c5deedc610f020" => :el_capitan
    sha256 "ff7a30ffd16033128d31712097200925c4391e6aebf86f5bf1c5deedc610f020" => :yosemite
  end

  test do
    system bin/"behat", "--version"
  end
end

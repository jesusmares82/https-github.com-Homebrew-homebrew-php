require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Behat < AbstractPhpPhar
  init
  desc "BDD framework for PHP to help you test business expectations"
  homepage "http://behat.org/"
  url "https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar"
  version "3.3.0"
  sha256 "d99fdf7e7d9459903ae2f9628e0459ab3357a1c93e0b55ad32f60e625c3cb9f7"
  head "https://github.com/Behat/Behat.git"

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

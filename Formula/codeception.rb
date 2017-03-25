require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.10/codecept.phar"
  sha256 "8e8e34b55d32947a01d5a91c703a7d7426ad65a07117af9716f614d882f58de2"

  bottle do
    cellar :any_skip_relocation
    sha256 "bec2d6dbb485e97683182c1a035c072af12e75a6231d2277759704ded0cbe319" => :sierra
    sha256 "bec2d6dbb485e97683182c1a035c072af12e75a6231d2277759704ded0cbe319" => :el_capitan
    sha256 "bec2d6dbb485e97683182c1a035c072af12e75a6231d2277759704ded0cbe319" => :yosemite
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "#{bin}/codecept", "--version"
  end
end

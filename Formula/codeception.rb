require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.9/codecept.phar"
  sha256 "aa0c5a1a2a473fbbc5fa0d35afa7ec54a8642e3d962bdd99d753fe5ef93e2742"

  bottle do
    cellar :any_skip_relocation
    sha256 "87c6784a931fe1769c309b52bb2ddf480f18c280bfe742739d27fd793d6a58c2" => :sierra
    sha256 "d2f9757891b300c45f1f4c8ce9bc20be3047aa5c233d639d8efa97d3a0473f60" => :el_capitan
    sha256 "d2f9757891b300c45f1f4c8ce9bc20be3047aa5c233d639d8efa97d3a0473f60" => :yosemite
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

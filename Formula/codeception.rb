require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.8/codecept.phar"
  sha256 "85c610057131fe5a473ff7b79fc671ff7e2f09b9afb0c4a4318e48567ed48d2a"

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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.0/codecept.phar"
  sha256 "4457ceff1b3ca22e3052beec6fcc933a53b02633bc51b917390cc4648817ce60"

  bottle do
    cellar :any_skip_relocation
    sha256 "3631bfa788a3dfd44ca5383d944232bc5fee28d8d90270b8d02fbde055039d4c" => :sierra
    sha256 "5a3609f3e86c39aaad45b2242a528cf2f65c4194cbf9fa1374f783fb69433bbe" => :el_capitan
    sha256 "5a3609f3e86c39aaad45b2242a528cf2f65c4194cbf9fa1374f783fb69433bbe" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.0/codecept.phar"
  sha256 "4457ceff1b3ca22e3052beec6fcc933a53b02633bc51b917390cc4648817ce60"

  bottle do
    cellar :any_skip_relocation
    sha256 "1b83ee38316db144f7038c06a994070bc002d564e8ae1144e46e10c3c9099546" => :sierra
    sha256 "4ec17e378c7f6624da89557307d07d31675fd5a89ef63f6653816cdc30d92765" => :el_capitan
    sha256 "4ec17e378c7f6624da89557307d07d31675fd5a89ef63f6653816cdc30d92765" => :yosemite
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

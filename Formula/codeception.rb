require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.10/codecept.phar"
  sha256 "8e8e34b55d32947a01d5a91c703a7d7426ad65a07117af9716f614d882f58de2"

  bottle do
    cellar :any_skip_relocation
    sha256 "0922e29a8ee3dc8d45d6a458f094d3f5611106d0f16d0d974f97735db718dedc" => :sierra
    sha256 "0922e29a8ee3dc8d45d6a458f094d3f5611106d0f16d0d974f97735db718dedc" => :el_capitan
    sha256 "0922e29a8ee3dc8d45d6a458f094d3f5611106d0f16d0d974f97735db718dedc" => :yosemite
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

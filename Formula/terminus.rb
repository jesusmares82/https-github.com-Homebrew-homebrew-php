require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.0.tar.gz"
  sha256 "edf2312694389b35e39427ea77790623c4bc3a13d57d4d38ac001438786f64dc"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f14cd6e866f3e296c46a7a7c2172a02bf5fa73a39c8d040aea1aa3a4b219c7f5" => :el_capitan
    sha256 "bf49e352b056139a7a9765cd56e83ec662feb24932e8fd7536485ca96193460e" => :yosemite
    sha256 "256bfd570d3f590dd9552b0467d0dabc550b64376f9ad47f3cdf610d4b90d888" => :mavericks
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    rm "bin/terminus.bat"
    rm "bin/behat"

    prefix.install Dir["*"]
  end

  test do
    system "terminus", "cli", "version"
  end
end

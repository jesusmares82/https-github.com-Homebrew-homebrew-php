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
    sha256 "456bdd51632ddcde1deeb47497ed2af1ed14cf49d71810274f0a5966a8bc9268" => :el_capitan
    sha256 "e9331e60123cac2322f9fd3abf5ebb3a90de483a7c0b550d25e45845a8986b99" => :yosemite
    sha256 "3abbaecf0563c1ae0cfe18d279af2cfd0792d80e3935a7b18314a1ca8cd348bb" => :mavericks
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

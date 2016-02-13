require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.10.3.tar.gz"
  sha256 "e5ee5b3c1004c2f8dabf160c14f95d953602e23b0c55d13813d549b4e171f117"
  head "https://github.com/pantheon-systems/cli.git"

  depends_on PhpMetaRequirement
  depends_on "composer" => :build

  def install
    system "composer", "install"

    rm "bin/terminus.bat"
    rm "bin/behat"

    prefix.install Dir["*"]
  end

  test do
    system "terminus", "cli", "version"
  end
end

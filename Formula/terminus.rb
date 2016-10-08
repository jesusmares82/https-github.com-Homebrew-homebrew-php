require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.3.tar.gz"
  sha256 "3fa7843d9cedfa6e5ee4fecfe8405156ae012128112d9c30727b69f3172a49bf"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "fddfe6d48408a1050de0e6018dd9a2d17655f852933fdd742f1ca129b3a77ecf" => :sierra
    sha256 "fca0be7f546dedd9a3a5f325c0681f98c9b4855b8abcc540d83935740182ad3c" => :el_capitan
    sha256 "3bb3990b8d99c06790e84200e32edbbb5aeeacd5354bcc4c943f515932141815" => :yosemite
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

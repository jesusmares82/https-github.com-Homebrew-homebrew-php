require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.7.0.tar.gz"
  sha256 "254c3b022bc4931321b61a434f77f62552a177dbd12bc004a83218b17507b022"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9e9b3222a8c677aaceb7b4906b09a08ecdb6ecfb65b875c71534598dd60c6fad" => :high_sierra
    sha256 "f637c3141be70798760006e7e688b76fdf5fa65fe005d97488bf8963d1176f14" => :sierra
    sha256 "bf1f9595d1c2da9bf17527cf3258525f051591c5e62aca7ee8b04be94882cfae" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    prefix.install Dir["*"]
  end

  test do
    system bin/"terminus", "self:info", "--field=terminus_version"
  end
end

require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.6.1.tar.gz"
  sha256 "7f07d7d5275b26e3f13ec1cc1978a50b077876a3577d26033f8ca615454d9855"
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

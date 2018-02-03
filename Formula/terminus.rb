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
    sha256 "d10c2e22800455755a3e3ddb30c3cbc2c03d7b726213f6ab616b15b761888939" => :high_sierra
    sha256 "9e93fad9ac3927b0b977b0387dd346e263ccc38683eadc118a2d220214e4e641" => :sierra
    sha256 "eb58bfda108430d2a78eb871c10a5ad86a419c8f50eaf43cba3c5680ff1f6262" => :el_capitan
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

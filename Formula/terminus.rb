require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.3.0.tar.gz"
  sha256 "1d1c3657653676e0bb7fa4643fd80163383d9917d4c1af9a4bf7647d13970ab0"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f47e6ab74d9dd955fc51ee0b96a94f29f236999c3650d1ee689e57d69322fbe0" => :sierra
    sha256 "5fddf49fcdbcd490829800897f556f8d579f5c88d8553e1d94407f78e63e64f5" => :el_capitan
    sha256 "2642d90060eb66222d2d46ce2ed0a3ec87b940ecf32009840255de321f5c16f3" => :yosemite
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

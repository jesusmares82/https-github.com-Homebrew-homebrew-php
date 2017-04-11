require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.2.1.tar.gz"
  sha256 "6a3bc536d81ab2e0ef6ef9a1b621dde9046fbe51a01c5088dd7baa6e55bfb2cf"
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

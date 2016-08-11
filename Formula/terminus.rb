require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.11.4.tar.gz"
  sha256 "39edb928949914c92cb6d515072d16d1b59a04f1c4b3f29d36151deed2eb98da"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "64ec5481adaec809639a218753c2a5034adce03dc8c726f2d20e1b1715986c65" => :el_capitan
    sha256 "6e31b16673b1748533480a6fa0021242d22e831d48e3be26fa2deb671ec98e8f" => :yosemite
    sha256 "904f524bf7fda746dec2cdf91078e84b27026193737770d65119e35246d839b1" => :mavericks
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

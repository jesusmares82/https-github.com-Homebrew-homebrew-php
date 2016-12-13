require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.6.tar.gz"
  sha256 "c71a0983edf93879e14da00f08128a0a47d493d4aaf4ccf58a86c3f6b5e74c95"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d82b43327566f284aace7ae1c32e52164f6940545f19c1c40a4e48a5b4ee0ffb" => :sierra
    sha256 "ee8c8da1d80bc48f61deeff04a354c4814a08d4a1aac9e733ac0bcb8eea31e21" => :el_capitan
    sha256 "d3e3af1fc6a4194b36878163df48a4d2d85501ce741044953ffbab7419b96dfd" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    rm "bin/terminus.bat"
    rm "bin/behat"

    prefix.install Dir["*"]
  end

  test do
    system bin/"terminus", "cli", "version"
  end
end

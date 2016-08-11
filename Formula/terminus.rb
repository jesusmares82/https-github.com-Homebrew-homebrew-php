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
    sha256 "e96a3f2bc55524ecdc51791f59ee79ba5453d3690ca45abf7bdf7c86a473cd61" => :el_capitan
    sha256 "ba7899aa4919c1ccb94c3b680ee641b868fa20c585c82070fafe578bfa2245a2" => :yosemite
    sha256 "1cd63d46742dc17eb129b9e12a483bba8d0869bf56c7989a0919877deb60ebb4" => :mavericks
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

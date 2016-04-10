require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.11.1.tar.gz"
  sha256 "bb74ef83ee03c0baade0ba2bd5847158c9448a48064cb9c131c6cf1f4d2456d7"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9baa1cc8bc5f443947048114656d8c6408d0db09c41a44a929706193e895e341" => :el_capitan
    sha256 "203c78c641ce6d943847bdb29edccce6eb7432c261b4fccc0cd8eaf3a8f80445" => :yosemite
    sha256 "4f2d5f3aa54617f4e9632cdc26c91c28c3cff8a4c7c1a0fb132f686d27c5dc3c" => :mavericks
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

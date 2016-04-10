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
    sha256 "2357d35e41d758e20231cc6866a91b4c920ec69c08c8e1a99b87fc0be685efa5" => :el_capitan
    sha256 "36113383e64d2533886595686d87a57dcd0f4cb91d27aedf6cb09d7f98753a9b" => :yosemite
    sha256 "68bfa4324c95071aa7dc214fe3b7747e9862f5dad339979948166fd1c548107b" => :mavericks
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

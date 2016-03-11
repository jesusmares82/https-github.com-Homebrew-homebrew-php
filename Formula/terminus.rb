require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.10.6.tar.gz"
  sha256 "ae01e55d93bdafd05364e4138d6020dc492b3bfb7f8d06970ae0e4437fa36d4b"
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

require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/cli"
  url "https://github.com/pantheon-systems/cli/archive/0.10.3.tar.gz"
  sha256 "e5ee5b3c1004c2f8dabf160c14f95d953602e23b0c55d13813d549b4e171f117"
  head "https://github.com/pantheon-systems/cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ede4ba2eb618bb04a38bae62a09a4f949cef6d42c92b52e6cf50145f2f7d7b2" => :el_capitan
    sha256 "dcb05200c29d9174b1246451394b3741e0ec1233ce3fff08fac718661012203a" => :yosemite
    sha256 "0ff8e074a27b2834c6d60f8cc81bd1428912d2f060368af6470a43cfa0a20032" => :mavericks
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

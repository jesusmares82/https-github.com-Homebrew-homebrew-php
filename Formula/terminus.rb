require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.10.5.tar.gz"
  sha256 "dbc1a7ead80cde49803dfb77f9b402dda03c77db58fae9b1b70f6fe5c304a10f"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "21b700fbe1f852e5b967a70fae6c8a8a5e2b80d6786807ec1dd0f5d69f59d47a" => :el_capitan
    sha256 "7cd7c9828c030cc2403c435aa820c29fd991830a722e41664038fba438f48539" => :yosemite
    sha256 "751ad2ff16f5f7a8bdc7c14e3e773edad97999ae95030e70edd4367846a80386" => :mavericks
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

require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.1.tar.gz"
  sha256 "ec58485fa5ccacb6e32d304a6e965ea973bf9aaf323afe147a2dae6aed1635d7"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "86fd88f8a4a9d7209f315e167fa27e12f5a6f63c872c69166048e2a8e3e75702" => :sierra
    sha256 "b64d2a0eae0c8fa993c4f430dcf1d9140e5175ab781bf89fa4a8b7062b9a84d9" => :el_capitan
    sha256 "d614632a63d171b44f183b105afd00858a9efbb0918592555c7f0f132c94968f" => :yosemite
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

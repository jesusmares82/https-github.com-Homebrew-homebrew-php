# This formula tracks the 0.13 branch of Terminus
# Terminus 1.0 is a major breaking change and users may need time to adapt
require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class TerminusAT013 < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.6.tar.gz"
  sha256 "c71a0983edf93879e14da00f08128a0a47d493d4aaf4ccf58a86c3f6b5e74c95"
  head "https://github.com/pantheon-systems/terminus.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "ef8006a14872a7770eee4571dd1164af994f5cfa3a2420e505c946124cac9b52" => :sierra
    sha256 "a5fa9f12db583d3d2658cc8f48b4e34f4d9a2cbfc3ce9eaf2479eba70ba758a9" => :el_capitan
    sha256 "384663c71dfe8a1f5f6b10855d5b81740b92b91b0d79add013522c4f90800358" => :yosemite
  end

  keg_only :versioned_formula

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

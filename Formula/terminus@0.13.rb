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

  bottle do
    cellar :any_skip_relocation
    sha256 "258772b4096aba8d589aebcf3a1c5341e6badadea4e2b04e1fc5baeff1c2a417" => :sierra
    sha256 "b9562051b13b2b0a8a64d47dee99c932866306cdd9d1d17946e36ee43f61e2e5" => :el_capitan
    sha256 "bdfa5baca6ed85c78063e313f12e1b4c8161f73c74eb7888f6a118f09b1b4eff" => :yosemite
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

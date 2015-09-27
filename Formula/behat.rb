require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Behat < AbstractPhpPhar
  init
  desc "behavior-driven development framework"
  homepage "http://behat.org/"
  url "https://github.com/Behat/Behat/releases/download/v3.0.15/behat.phar"
  version "3.0.15"
  sha256 "9f29c36f2795255f67ae9423b0dc458b203b326953aa526404c82d836fa688ec"

  test do
    system "behat", "--version"
  end
end

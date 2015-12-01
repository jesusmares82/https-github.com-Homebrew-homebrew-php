require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Climb < AbstractPhpPhar
  init
  desc "Composer version manager tool"
  homepage "https://github.com/vinkla/climb"
  url "https://github.com/vinkla/climb/releases/download/0.7.0/climb.phar"
  sha256 "50c62a80f487abda75cc2eebb15b7ce7921eefc6014e5c3e4fc82eb5be2074c4"

  bottle do
  end

  test do
    system "climb", "--version"
  end
end

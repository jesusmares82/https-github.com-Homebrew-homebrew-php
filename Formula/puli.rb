require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Puli < AbstractPhpPhar
  init
  desc "Universal package system for PHP"
  homepage "http://puli.io"
  url "https://github.com/puli/cli/releases/download/1.0.0-beta10/puli.phar"
  version "1.0.0-beta10"
  sha256 "9aa39070480e5faaf61fb8cb92530cf7fc92ed29e3873a0f79448d6812caef3b"

  bottle do
    cellar :any_skip_relocation
    sha256 "0961bda55a77b816c31f8501d91ff78e5071dde621ef1682144f0b8398a3d6fd" => :el_capitan
    sha256 "05660a605bb3b90541a301170d6beab45583683e792f0f82d92946fb85c3af8b" => :yosemite
    sha256 "3adb5471eea219968b5a7ee17752a1be620a1025cb6115144ad53a7516923117" => :mavericks
  end

  test do
    system "puli", "--version"
  end
end

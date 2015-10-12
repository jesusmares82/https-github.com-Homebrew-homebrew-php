require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Puli < AbstractPhpPhar
  init
  desc "Puli is a universal package system for PHP"
  homepage "http://puli.io"
  url "https://github.com/puli/cli/releases/download/1.0.0-beta9/puli.phar"
  version "1.0.0-beta9"
  sha256 "6092944496f4cce2c0523ee58e8ad645394f8da15e2476f9c0eaa8c1f8264ef1"

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

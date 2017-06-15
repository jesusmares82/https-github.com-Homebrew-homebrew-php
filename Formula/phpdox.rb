require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.10.0/phpdox-0.10.0.phar"
  sha256 "a5e41d300dbf05a79f20e03845cf91ef884c37a94a3941a5bea3932e9d48a816"

  bottle do
    cellar :any_skip_relocation
    sha256 "7fb217dee5ed31c1f9ac018b7363fc84a6af1261815eb40146ee708d738176f1" => :sierra
    sha256 "5021b218d542b7524d5a604426f719c3d46cc86a0752c53334b4526024bd31d8" => :el_capitan
    sha256 "5021b218d542b7524d5a604426f719c3d46cc86a0752c53334b4526024bd31d8" => :yosemite
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end

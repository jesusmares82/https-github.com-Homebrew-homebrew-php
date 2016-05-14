require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.11.3/drupal.phar"
  sha256 "a74fb7b7656cf854e7683cd32fc5c7f59f2ae3245f0ffebbb56f6160cf150e95"

  bottle do
    cellar :any_skip_relocation
    sha256 "42c0484074ba08dc6af2b66641b8597c75b92accbd80365a95e270045a63103f" => :el_capitan
    sha256 "f460dbf94b28fcb1792e09b4acb47526ea031ee5bedaa0d3975de3039464bb8e" => :yosemite
    sha256 "57320fe0b5df6f94253e2fab8dd50ef0b79d448401a03578b3a5e0050406cccf" => :mavericks
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end

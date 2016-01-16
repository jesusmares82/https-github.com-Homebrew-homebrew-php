require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.6.1/box-2.6.1.phar"
  sha256 "abdadc1b1c79a60ac8aade62d9eea705d9a4bb69ea0e31e4592e6eb9489cb357"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe91af7752c0e69cce243f0e1ee7c552872e33f8efc3320750becd8974ee56e0" => :el_capitan
    sha256 "16fe74c0b7d171434904aa3ce83fa0d6b7f2ce1d62482f71004452b432c07572" => :yosemite
    sha256 "74f3c77e1e3dcd6644e7274d237f842c758950ece546366b0645c4de9d6539e7" => :mavericks
  end

  def phar_file
    "box-#{version}.phar"
  end

  test do
    system "box", "--version"
  end
end

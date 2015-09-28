require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.8.1.1/phpdox-0.8.1.1.phar"
  sha256 "1424d4603e0fdb0c80e39266fb832060bffbcc665a8c8d29b411e88d096d5da2"

  bottle do
    cellar :any_skip_relocation
    sha256 "ecf5998f3f2d2a8e78d654edc5c7b1971e65d280a4742119bbbec11b4f62944b" => :el_capitan
    sha256 "859176b62c12d0998fbe93d83081403bbbeb1b49c07735d509d6889e9cb2a349" => :yosemite
    sha256 "e1071dce283fcf3193a45dddcac7042b4522137118b1ea74e3074ff7039c0203" => :mavericks
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "phpdox", "--version"
  end
end

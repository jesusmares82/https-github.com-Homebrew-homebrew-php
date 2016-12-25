require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.9.0/phpdox-0.9.0.phar"
  sha256 "d51b294b4e6a0681ce6553199d27d85101df1426b176272ed5b2492c97e6c11f"

  bottle do
    cellar :any_skip_relocation
    sha256 "fd01045fdc17fcc9ef8af18465dbd848c5481282f0ccd6df53907351084ae1d7" => :sierra
    sha256 "ecf5998f3f2d2a8e78d654edc5c7b1971e65d280a4742119bbbec11b4f62944b" => :el_capitan
    sha256 "859176b62c12d0998fbe93d83081403bbbeb1b49c07735d509d6889e9cb2a349" => :yosemite
    sha256 "e1071dce283fcf3193a45dddcac7042b4522137118b1ea74e3074ff7039c0203" => :mavericks
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end

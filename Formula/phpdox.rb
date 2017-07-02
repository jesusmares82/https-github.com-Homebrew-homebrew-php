require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.10.1/phpdox-0.10.1.phar"
  sha256 "a665f5af5369e5781c2008865c2e2adf08726cdaa037516987b11bc7a0f89898"

  bottle do
    cellar :any_skip_relocation
    sha256 "35cce3b587e2e969bfbb28c88fedb78f12c29f4e4830a6bd59e53a720ce62583" => :sierra
    sha256 "48c736fe27a934ae8820ba445a35aed302954f43a2609f141678606085ceb1e6" => :el_capitan
    sha256 "48c736fe27a934ae8820ba445a35aed302954f43a2609f141678606085ceb1e6" => :yosemite
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end

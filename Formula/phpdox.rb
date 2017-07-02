require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.10.1/phpdox-0.10.1.phar"
  sha256 "a665f5af5369e5781c2008865c2e2adf08726cdaa037516987b11bc7a0f89898"

  bottle do
    cellar :any_skip_relocation
    sha256 "dcd72252329a41bbde97bd67318bab8bde3fcf3d055ec9c3f7dc190c0b980674" => :sierra
    sha256 "a8446ba415a1eb4f0bba0dde4f3295f03aa7d139a806a1f53da379f02bed0d7b" => :el_capitan
    sha256 "a8446ba415a1eb4f0bba0dde4f3295f03aa7d139a806a1f53da379f02bed0d7b" => :yosemite
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end

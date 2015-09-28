require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.5.3/box-2.5.3.phar"
  sha256 "95a3098b27c15939cbad9bba72c07cf4d425a760e979117ab3279e7ac209cfeb"

  bottle do
    cellar :any_skip_relocation
    sha256 "3a848586a4b3c23a90d5c6dac9f48049d87d29021c67d4a45acaf037acd5897f" => :el_capitan
    sha256 "80858c7aa8bf16d1575df1fa695fe8730735dc1130a23e442a1818c1ead7a488" => :yosemite
    sha256 "750d549a2885c4cf4d69961fa34c0d5434db03ebfbb7dd25f3d01ac0b864fd78" => :mavericks
  end

  def phar_file
    "box-#{version}.phar"
  end

  test do
    system "box", "--version"
  end
end

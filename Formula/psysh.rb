require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.4.tar.gz"
  sha256 "6c57c5586624412b2e39dcb6d8e3104af05aad5ed1a7c71aee6b56453af1cab2"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8cb80944b06ef8633fab4e14e29662f3e49d58a457dee1023b4dc9c44d07c346" => :sierra
    sha256 "f98be6f9fedde80db4f1a0a088aab1a455454c84dcb06498c40c6a9bfa35f2f8" => :el_capitan
    sha256 "6890179af5b723a2d1f9c521afac4ef174266d342de8eab4f6adc357f509d16d" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install "--no-dev"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/psysh"
  end

  test do
    system "#{bin}/psysh", "--version"
  end
end

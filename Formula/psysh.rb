require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.2.tar.gz"
  sha256 "c7c52777c3d2f72ff5784f84130df47967612a7d82e1c2f4d95edda04949e86a"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "29ecbc6c2603b87be953b8271a6780f6b2d72ca8ae3013532a9c65bf54b77102" => :sierra
    sha256 "50b57c8740bc7b37c086dfeacf05d14d00f17ece7e643aab2c2586b1138d7c80" => :el_capitan
    sha256 "6f4b893f90e7e9c1c5265d7f6fecf3228668d2488baf4c53c5f361f0a61d2cb4" => :yosemite
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

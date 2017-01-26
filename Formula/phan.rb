require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.8.3.tar.gz"
  sha256 "3fde034a755b37af3270a9f3d30e01ef29558cb622c028c7f8380d98d5e733ae"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7feda23d86c5ddec15b864e852310343bb53c8405403af707c3df0ca768cbf99" => :sierra
    sha256 "c24b5b20e81e98eea83f397520f39483adeeab475359eb1032e72cda971f7ab3" => :el_capitan
    sha256 "fbc456781a3e7004371b2d69fea184290c31a3866a98a376d5c8053eb0449c2e" => :yosemite
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "-h"
  end
end

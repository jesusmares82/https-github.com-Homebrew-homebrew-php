require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.2.tar.gz"
  sha256 "a255427696066bebc440ea792c63a68fc80cbfb6de5d837eaa02fbae03670054"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1771c48b837614ee2e9b75013477315d91a18bdb6fb04f66b5ffc77c6c20f1de" => :high_sierra
    sha256 "23c31e9d2a3d343eda3d1e30ecea2ec85bcdfb7d9fc27135d2ae97bf55c7bcd7" => :sierra
    sha256 "f6fc96f22127a3eb8520e2340f2a5b1101bd11678bc774c28ded410c0a8337ce" => :el_capitan
  end

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end

require File.expand_path("../../language/php", __FILE__)

class PhanAT010 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.2.tar.gz"
  sha256 "a255427696066bebc440ea792c63a68fc80cbfb6de5d837eaa02fbae03670054"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1367e7dee09300327a86374709b631a2908b29f02b19120277602f09a741adf2" => :high_sierra
    sha256 "9ab21b753363215c0263be7d155e4a1353e90d4431c3693a6f3cf42fcca02024" => :sierra
    sha256 "94efb4985bb039de568cc1cd3917e683a850c94117e512508930569b84ce2307" => :el_capitan
  end

  keg_only :versioned_formula

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

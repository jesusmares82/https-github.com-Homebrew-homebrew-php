require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.8.8.tar.gz"
  sha256 "44504aac5e98431dd7beceec9f96f9d601d7c3f15cf1c579f7203a36cb607235"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "da22f5f1ddbc1aea2ecfad337e6935751fa16cd2c31f8f5bf0b37532e81edcc7" => :high_sierra
    sha256 "3a0b9e3f1f877aa9f0dfff86873391d7af92a25f362bdb55b7b40c610d9e67d8" => :sierra
    sha256 "33351a23e9a464bc521fec2fcce86fb77c0c3643f2bb1369dbb88a10822e59d5" => :el_capitan
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end

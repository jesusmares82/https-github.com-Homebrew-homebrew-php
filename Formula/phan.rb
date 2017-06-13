require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.9.2.tar.gz"
  sha256 "1bd683f89bb3f5954dcac922f1c20c08802813a9a12bbc8c7e7478742cad2a0e"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2d7e7f318098045e6e28f9f261acab007609eef1adc13365df5d95c300e16478" => :sierra
    sha256 "ac2465b89af265f0f97027c234981fa0c5880b3b53d4ef0ebf7f34ad2682430d" => :el_capitan
    sha256 "8ab4447f70417a6a9c52bc5b9a5203bc7f43a978d65393d9f96ed0d0b5648f2d" => :yosemite
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

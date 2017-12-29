require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Envoy < Formula
  include Language::PHP::Composer

  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/archive/v1.4.0.tar.gz"
  sha256 "8e7892941136bec0352430ea4f6f592fc6dc58f5123ce82b9ea9727503cfe706"
  head "https://github.com/laravel/envoy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f954113349533debbb9f0fa3d2490d309e6acfdd3c151b2e6ac22af2ce583ece" => :high_sierra
    sha256 "c15e2b64b35d29e885ce7aeb05da6246c89f9c37b9913fd18413255be4129176" => :sierra
    sha256 "da2bfe030ea25dee5d36d2c005923e7672f7919fc299e5046dc18409a2571ac8" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"envoy"
  end

  test do
    system "#{bin}/envoy", "--version"
  end
end

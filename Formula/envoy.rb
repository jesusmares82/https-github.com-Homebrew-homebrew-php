require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Envoy < Formula
  include Language::PHP::Composer

  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/archive/v1.3.2.tar.gz"
  sha256 "e50e9958723bbc64e9eefbd7a635b8a02084005153652ea65a87c9e92b6ca16a"
  head "https://github.com/laravel/envoy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1baa0fec0e611579ffa57a29bcb7462be380bc5a396a76608625a19b8ebc70aa" => :sierra
    sha256 "030419f798ad575386c580ebf07d46a9cc7773f454a4a832285953bcb76b48a2" => :el_capitan
    sha256 "418181f9aa9a77e9bbe1c0dd67ea05fd2b5b4f9ca37e75ab39de39944212f6e3" => :yosemite
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

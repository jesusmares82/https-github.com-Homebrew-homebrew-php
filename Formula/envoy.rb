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
    sha256 "b2b8fd34d74345001b523aca3708be3453733343316b2e74c518445278d39bb2" => :sierra
    sha256 "0b0ac19e72331cc35bcb47379dbcde32e10ec36de3f77e820638b521cbcd44e3" => :el_capitan
    sha256 "2bc496be1f1d578ea63f94d5eb6010ed8d43bc1f4ca1e5fab1b8f543c4c12a0d" => :yosemite
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

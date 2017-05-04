require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Envoy < Formula
  include Language::PHP::Composer

  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/archive/v1.3.3.tar.gz"
  sha256 "dba29896b10994b78989a9c1e5a28a9eea8225f497322e031a9a1af1b1ee37f0"
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

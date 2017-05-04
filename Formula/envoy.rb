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
    sha256 "92f77c8c65769fe6daad6fb7213824f0b268fb3b1906133cafbdf4fdeddf7cac" => :sierra
    sha256 "4cbcfa1f30beead28927e1ba8da3fb45626d525c4b8a39ec59b34d355074d601" => :el_capitan
    sha256 "c448134a6107c24ae7f24950d5ecfc867a1c67755a8aa65b059904fd96009957" => :yosemite
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

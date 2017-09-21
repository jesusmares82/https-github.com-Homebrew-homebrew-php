require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Envoy < Formula
  include Language::PHP::Composer

  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/archive/v1.3.4.tar.gz"
  sha256 "c53c043203ee9d611603affefde11f983256ea2df442cb96ac0a67edbe2e6222"
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

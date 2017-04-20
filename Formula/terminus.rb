require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.3.0.tar.gz"
  sha256 "1d1c3657653676e0bb7fa4643fd80163383d9917d4c1af9a4bf7647d13970ab0"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2aa07ac39e5b48e0d940b8b36033fcccec805f1fca8bbfeca37179c48a97c89f" => :sierra
    sha256 "c9436bf36b7a8075f7ccd8ef5fed7d5629794bbf9dac6c97bbdd3f05f39c3ac4" => :el_capitan
    sha256 "5be55176adc5fea45b17a1a832221386f24b4cad9ad1f73d04a080417ed401cb" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    prefix.install Dir["*"]
  end

  test do
    system bin/"terminus", "self:info", "--field=terminus_version"
  end
end

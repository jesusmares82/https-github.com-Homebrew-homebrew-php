require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.0.0.tar.gz"
  sha256 "1c135cada11fa49ac58ebc1a64e4e7f2aff13d39f5fc1f8d1e1dd50498ca2fb6"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "9f053fd6e089b1cf7802946c018d65af8f83a74fb055f73cdb55b6584b648875" => :sierra
    sha256 "d2ad8e0e1e1f496026fb19a604d53ca7abe5d4af437526ddddd2f260e7be5a77" => :el_capitan
    sha256 "818d97f5301dd6bcc75e8c4c3d1567f5b2f41ae42e8411a9a683a2f039eab372" => :yosemite
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

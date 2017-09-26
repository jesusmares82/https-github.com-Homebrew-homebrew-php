require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.5.0.tar.gz"
  sha256 "d0ca4b586cb712b0e489d3c5061ee26f9cf9905f12a984a2329c8e74d5e1a7b9"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "30110c5e0cb4e70bbaae812545c9bcae11a4b0e3d17ff2abc19ef6c683c5365e" => :sierra
    sha256 "600c76860699768fe69a3d2f1dd865b7c20ff7a5c6739bb38aa4dd2c0f8ea0a7" => :el_capitan
    sha256 "90328f0bcb3aa36bb0aac88a54effd7f8af722c32064322ee1cd2b0d13c47c00" => :yosemite
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

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
    rebuild 1
    sha256 "e42943de1fd3fe8d102aada1ffab4579e0d0303d31bccf2615a7ddaf7f9fa5d9" => :high_sierra
    sha256 "baf670acfd1086b639b8adda54f70ba1b5629261e7b2aea165c07d080767bbc3" => :sierra
    sha256 "328f89edbbf669149022092ef4ac8629eaae016402aa606830bcda9578735acc" => :el_capitan
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

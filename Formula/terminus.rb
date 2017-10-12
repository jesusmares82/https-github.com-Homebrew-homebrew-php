require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.6.0.tar.gz"
  sha256 "14523133139296c189c94545ce6c3002673a7781fce3452d1448929f262a33da"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c56d4f94baea7c63cf83495e0257707daf183261d4a4fbab477213f3304eea18" => :high_sierra
    sha256 "57900b1c20abac94b621d33f7da9574e1d1a2e9c1297c0b684b477d91e73fe47" => :sierra
    sha256 "15f775fb9fb7c737bbd4c096d6c077ac8f4eaeed47680ec86df3d56d805fbb87" => :el_capitan
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

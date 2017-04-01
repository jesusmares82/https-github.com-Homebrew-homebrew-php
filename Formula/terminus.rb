require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.1.2.tar.gz"
  sha256 "ea847ca699bffb5f3bfbf80ca21b8cb77b79369ab5ccfefbdcb1a96348c23f0a"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8d211151a7471ea5d9d22a0e97106d07aa4587e8aa87063fa8abd0c69197e1dd" => :sierra
    sha256 "f9165c55b9de2ba64e3a4a7968bfdd1ac7322ef51a7d2647ef8012ba629358d1" => :el_capitan
    sha256 "b0c543afe9527c6f6634ae81f6eff2ecb2526cef277e34d5daedc866cc1ec00e" => :yosemite
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

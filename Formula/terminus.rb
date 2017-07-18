require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.4.1.tar.gz"
  sha256 "0dc60296f82958c82dcc73cbc24d186a3917ef806d9d1075fd92f343154f6284"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8cd484522f6edee4d1bd9a0c59e2dd1fe8721c9f4a0bfb4c86c17f8199355a5b" => :sierra
    sha256 "f51cd17adb9b6edbdf77bff6ac7bc03c8e30de88e99cb69c7a7a5813921996a1" => :el_capitan
    sha256 "6b2fe379ac576ddadc672720db37610d7cad8cb0b0076d51d58f50c7f55213ee" => :yosemite
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

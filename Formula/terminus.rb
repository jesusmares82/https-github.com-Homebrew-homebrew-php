require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.0.0.tar.gz"
  sha256 "1c135cada11fa49ac58ebc1a64e4e7f2aff13d39f5fc1f8d1e1dd50498ca2fb6"
  revision 1
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "94ee33aeff538795c331cf6e037bf1ba23fc6ab47f50d3095732a53dc0498c0c" => :sierra
    sha256 "67953d5f7971e9e9d92ed1fa5a9ce9db6c60a36b48e807f0ddce22ff19562a65" => :el_capitan
    sha256 "c4343d906f3082c3d85ac2a6764ad90e560a585a7ce4a989360ab37cb575a3ff" => :yosemite
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

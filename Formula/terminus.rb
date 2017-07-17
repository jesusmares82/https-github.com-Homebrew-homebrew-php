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
    sha256 "078638fb53ba75a1ade4832d6ac04fd58b0fbd6e6d4910a0548a1d9b3af2ca5b" => :sierra
    sha256 "1b1188c199c436e92b0a146bc17ec2a2c7aed538d89756bb3eae1d5a7975cf38" => :el_capitan
    sha256 "a2fa64522a61e990777d2ff8ffef0ae081e7cd1f3249ceb9b36d6c1a6c0abf01" => :yosemite
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

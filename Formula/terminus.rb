require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.1.1.tar.gz"
  sha256 "08bd846e7dc957205170c379ea9f4a03536746cd7b0175d8609b62051b352025"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "97f0b1f012a1511f44e3e483db47f71ce7333a216b69745b942f44eb7f6570c3" => :sierra
    sha256 "ab872a8308985443d6c4c524268d9e7b851620f7c4a69e94097fe9e416de4525" => :el_capitan
    sha256 "79bd38778ceec88b118788d644c0ce1c8fae9ee4807f86c1f3bc4ef8e34d431f" => :yosemite
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

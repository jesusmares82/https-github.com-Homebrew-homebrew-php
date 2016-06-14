require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.11.2.tar.gz"
  sha256 "9dfbd4c5ef5e639319c52163eadfc55d7b321b478cd6b3e85cf94aaaa11aaec5"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d9f16d48cb63101faa6341caa712598df2d2a9ef6fbd10b57f77d4bc2ee3c486" => :el_capitan
    sha256 "39c4f6823da5c6e85971e3a7bc6891594cd9bf3277a89fb5e0a76d556d08a5d2" => :yosemite
    sha256 "3f955c74f6f973a4be65f1c1937add63e4d447d259d497dd25a5e6ca8e4ff313" => :mavericks
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    rm "bin/terminus.bat"
    rm "bin/behat"

    prefix.install Dir["*"]
  end

  test do
    system "terminus", "cli", "version"
  end
end

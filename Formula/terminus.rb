require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/0.13.6.tar.gz"
  sha256 "c71a0983edf93879e14da00f08128a0a47d493d4aaf4ccf58a86c3f6b5e74c95"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "9f053fd6e089b1cf7802946c018d65af8f83a74fb055f73cdb55b6584b648875" => :sierra
    sha256 "d2ad8e0e1e1f496026fb19a604d53ca7abe5d4af437526ddddd2f260e7be5a77" => :el_capitan
    sha256 "818d97f5301dd6bcc75e8c4c3d1567f5b2f41ae42e8411a9a683a2f039eab372" => :yosemite
  end

  devel do
    url "https://github.com/pantheon-systems/terminus/archive/1.0.0-beta.2.tar.gz"
    sha256 "37b3a3046ac19315013e13fa3db697da180b7d1c0b71e9960d78c9df1e861e02"
    version "1.0.0-beta.2"
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    unless build.devel?
      rm "bin/terminus.bat"
      rm "bin/behat"
    end

    prefix.install Dir["*"]
  end

  test do
    if build.devel?
      system bin/"terminus", "self:info", "--field=terminus_version"
    else
      system bin/"terminus", "cli", "version"
    end
  end
end

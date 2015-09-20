require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Pharcc < Formula
  desc "tool that converts your php project into a .phar file"
  homepage "https://github.com/cbednarski/pharcc"
  url "https://github.com/cbednarski/pharcc/releases/download/v0.2.3/pharcc.phar"
  version "0.2.3"
  sha256 "9dee4f814aa04bd92a03b5f1aadbef80a567836d310319f4b2775673522fb959"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "pharcc.phar"
    sh = libexec + "pharcc"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/pharcc.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "pharcc", "--version"
  end
end

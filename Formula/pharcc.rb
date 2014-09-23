require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Pharcc < Formula
  homepage 'https://github.com/cbednarski/pharcc'
  url 'https://github.com/cbednarski/pharcc/releases/download/v0.2.3/pharcc.phar'
  sha1 'e57fb6cf2f2e630a64ab6fdb6c1ab0e9198a6aa1'
  version '0.2.3'

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
    system 'pharcc --version'
  end
end

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpcpd < Formula
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-2.0.0.phar"
  sha256 "ea4856166beb0dace104124deece3f6d43b9af6dbfe44e0bb41f45aba1d85b26"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpcpd-#{version}.phar"
    sh = libexec + "phpcpd"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpcpd-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpcpd --version".

    You can read more about phpcpd by running:
      "brew home phpcpd".
    EOS
  end

  test do
    system "phpcpd", "--version"
  end
end

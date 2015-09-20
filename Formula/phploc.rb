require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phploc < Formula
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-2.0.2.phar"
  sha256 "0ce805f48d778c49ae78af0b08a16efd2eba01ff31aa59e5374fad27e93c5558"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phploc-#{version}.phar"
    sh = libexec + "phploc"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phploc-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phploc --version".

    You can read more about phploc by running:
      "brew home phploc".
    EOS
  end

  test do
    system "phploc", "--version"
  end
end

require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmetrics < Formula
  homepage 'http://www.phpmetrics.org/'
  url 'https://github.com/Halleck45/PhpMetrics/blob/v1.1.1/build/phpmetrics.phar'
  sha1 '209202b00c81a534198a552b0c056d8a2c0dc587'
  version '1.1.1'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpmetrics-#{version}.phar"
    sh = libexec + "phpmetrics"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpmetrics-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system 'phpmetrics --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpmetrics --version".

    You can read more about phpmetrics by running:
      "brew home phpmetrics".
    EOS
  end

end

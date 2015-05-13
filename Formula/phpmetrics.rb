require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmetrics < Formula
  homepage 'http://www.phpmetrics.org/'
  url 'https://github.com/Halleck45/PhpMetrics/raw/v1.1.1/build/phpmetrics.phar'
  sha256 'e55f6ea1fe8046f538432b946fca38794ab9e3a88c5251e70c3b08abb7e7cd03'
  version '1.1.1'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpmetrics.phar"
    sh = libexec + "phpmetrics"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpmetrics.phar $*")
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

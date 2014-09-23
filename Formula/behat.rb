require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Behat < Formula
  homepage 'http://behat.org/'
  url 'https://github.com/Behat/Behat/releases/download/v3.0.12/behat.phar'
  sha1 'dea2f88668f64e300e2f5b0be6789a14af6092b7'
  version '3.0.12'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "behat.phar"
    sh = libexec + "behat"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/behat.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system 'behat --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "behat --version".

    You can read more about behat by running:
      "brew home behat".
    EOS
  end
end

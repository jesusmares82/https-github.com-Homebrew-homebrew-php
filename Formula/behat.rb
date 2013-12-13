require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Behat < Formula
  homepage 'http://behat.org/'
  url 'http://behat.org/downloads/behat-2.4.5.phar'
  sha1 '0c9b1950c106d0ad52a96010cf68484d2cfcd837'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "behat-#{version}.phar"
    sh = libexec + "behat"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/behat-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
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

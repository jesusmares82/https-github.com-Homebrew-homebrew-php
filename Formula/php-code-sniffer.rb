require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)

class PhpCodeSniffer < Formula
  homepage 'http://pear.php.net/package/PHP_CodeSniffer'
  url 'http://download.pear.php.net/package/PHP_CodeSniffer-1.4.7.tgz'
  sha1 '436448942bd7a12d37083f1c0838c9ba297dcb5c'

  devel do
    url 'http://download.pear.php.net/package/PHP_CodeSniffer-1.5.0RC4.tgz'
    sha1 '0f713d8b02b730f6ac2ccf497d5931dc77888018'
  end

  depends_on PhpMetaRequirement

  def install
    prefix.install Dir["PHP_CodeSniffer-#{version}/*"]
    sh = libexec + "phpcs"
    sh.write("#!/bin/sh\n\n/usr/bin/env php #{prefix}/scripts/phpcs $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpcs --version".

    You can read more about phpcs by running:
      "brew home php-code-sniffer".
    EOS
  end
end




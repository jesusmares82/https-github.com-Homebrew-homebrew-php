require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Mondrian < Formula
  homepage 'https://trismegiste.github.io/Mondrian/'
  url 'https://github.com/Trismegiste/Mondrian/blob/v1.3.3/bin/box/mondrian.phar'
  sha1 'a17dffd5e6cfe8025b348f648a6ca6a0a59a8840'
  version '1.3.3'

  depends_on PhpMetaRequirement
  depends_on PharRequirement
  depends_on 'graphviz'

  def install
    libexec.install "mondrian-#{version}.phar"
    sh = libexec + "mondrian"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/mondrian-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system 'mondrian --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "mondrian --version".

    You can read more about mondrian by running:
      "brew home mondrian".
    EOS
  end

end

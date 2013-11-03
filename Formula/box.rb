require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Box < Formula
  homepage 'http://box-project.org/'
  url 'https://github.com/kherge/Box/releases/download/2.3.0/box-2.3.0.phar'
  sha1 '59e95eb1480830a0e35a81e83c82aa3ada04753c'
  version '2.3.0'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "box-2.3.0.phar"
    sh = libexec + "box"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/box-2.3.0.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'box --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "box --version".

    You can read more about box by running:
      "brew home box".
    EOS
  end

end

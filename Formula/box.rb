require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Box < Formula
  homepage 'http://box-project.org/'
  url 'https://github.com/box-project/box2/releases/download/2.5.0/box-2.5.0.phar'
  sha1 '5664cb4603917a77ea71fb325845e33d886cccb1'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "box-#{version}.phar"
    sh = libexec + "box"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/box-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
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

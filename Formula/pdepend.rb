require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Pdepend < Formula
  homepage "http://pdepend.org/"
  url "http://static.pdepend.org/php/2.0.6/pdepend.phar"
  sha256 "71573a4b125a5e1ca42032af52095b2d96a39aafb26704529549c42d6833bf4f"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "pdepend.phar"
    (bin/"pdepend").write <<-EOS.undent
      #!/bin/sh
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/pdepend.phar $*
    EOS
  end

  test do
    system bin/"pdepend", "--version"
  end
end

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmd < Formula
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.2.2/phpmd.phar"
  sha256 "381e35943052e6de7809c5cf6ffdd9f9f3289de9755c2e00f8e1c35d091e88fc"
  head "https://github.com/phpmd/phpmd.git"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpmd.phar"
    sh = libexec + "phpmd"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpmd.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    (testpath/"test.php").write <<-EOS.undent
      function hi($msg) {
        return $msg;
      }
    EOS
    system "phpmd", testpath/"test.php", "text", "cleancode"
  end
end

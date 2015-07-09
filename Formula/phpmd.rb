require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmd < Formula
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.2.3/phpmd.phar"
  sha256 "5cd9d4754a0d2c41a403afe6b7b75e6994d90f8e8df3600a200398dd4271a31b"
  head "https://github.com/phpmd/phpmd.git"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpmd.phar"
    (bin/"phpmd").write <<-EOS.undent
      #!/bin/sh
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpmd.phar $*
    EOS
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

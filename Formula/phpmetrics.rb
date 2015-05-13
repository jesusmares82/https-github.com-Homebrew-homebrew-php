require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmetrics < Formula
  homepage "http://www.phpmetrics.org/"
  url "https://github.com/Halleck45/PhpMetrics/raw/34cf0888e7225d743fc01b467fbbd8a1d54226a6/build/phpmetrics.phar"
  sha256 "77fd4f29f76bf3f8c623e415ee834692077e9b49bd340a0c896f58a9697fe9a3"
  version "1.4.1"

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
    system "phpmetrics", "--version"
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpmetrics --version".

    You can read more about phpmetrics by running:
      "brew home phpmetrics".
    EOS
  end
end

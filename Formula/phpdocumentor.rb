require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpdocumentor < Formula
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.8.5/phpDocumentor.phar"
  version "2.8.5"
  sha256 "7613a3d6ffc182595b7423bc2373cd215cac269135f4b0f973e5c1b617b565b7"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpDocumentor.phar"
    sh = libexec + "phpdoc"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpDocumentor.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpdoc --version".

    You can read more about phpdocumentor by running:
      "brew home phpdocumentor".
    EOS
  end

  test do
    system "phpdoc", "--version"
  end
end

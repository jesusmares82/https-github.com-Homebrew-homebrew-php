require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Virtphp < Formula
  homepage "http://virtphp.org"
  url "https://github.com/virtphp/virtphp/releases/download/v0.5.2-alpha/virtphp.phar"
  sha256 "776bce2f6dfd252ef9d886f14d8bbca7cb9e328e69ad900cdf14a552e7e59d30"
  version "0.5.2-alpha"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "virtphp.phar"
    sh = libexec + "virtphp"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/virtphp.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "virtphp --version".

    You can read more about virtphp by running:
      "brew home virtphp".
    EOS
  end

  test do
    shell_output("virtphp --version").include?(version)
  end
end

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Behat < Formula
  homepage "http://behat.org/"
  url "https://github.com/Behat/Behat/releases/download/v3.0.15/behat.phar"
  version "3.0.15"
  sha256 "9f29c36f2795255f67ae9423b0dc458b203b326953aa526404c82d836fa688ec"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "behat.phar"
    (libexec/"behat").write <<-EOS.undent
      #!/usr/bin/env bash
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/behat.phar $*
    EOS
    chmod 0755, (libexec/"behat")
    bin.install_symlink (libexec/"behat")
  end

  test do
    system "behat", "--version"
  end
end

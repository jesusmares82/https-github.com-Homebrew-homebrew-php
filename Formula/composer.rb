require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/composer-requirement", __FILE__)

class Composer < Formula
  homepage "http://getcomposer.org"
  head "https://getcomposer.org/composer.phar"
  url "http://getcomposer.org/download/1.0.0-alpha10/composer.phar"
  sha256 "9f2c7d0364bc743bcde9cfe1fe84749e5ac38c46d47cf42966ce499135fd4628"
  version "1.0.0-alpha10"

  depends_on PhpMetaRequirement
  depends_on ComposerRequirement

  def install
    libexec.install "composer.phar"
    sh = libexec + "composer"
    sh.write("#!/usr/bin/env bash\n\nexec /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/composer.phar \"$@\"")
    chmod 0755, sh
    bin.install_symlink sh
    bin.install_symlink libexec + "composer.phar"
  end

  test do
    system "composer", "--version"
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "composer --version".

    You can read more about composer and packagist by running:
      "brew home composer".
    EOS
  end
end

require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Envoy < Formula
  homepage 'https://github.com/laravel/envoy'
  url 'https://github.com/laravel/envoy/raw/v1.0.11/envoy.phar'
  sha1 '00401ec8014a1744bebae14f8411fde6f2db551b'
  version '1.0.11'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "envoy.phar"
    sh = libexec + "envoy"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/envoy.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'envoy --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "envoy --version".

    You can read more about envoy by running:
      "brew home envoy".
    EOS
  end

end

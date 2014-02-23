require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Envoy < Formula
  homepage 'https://github.com/laravel/envoy'
  url 'https://github.com/laravel/envoy/raw/1.0.5/envoy.phar'
  sha1 '0e9a3097fdbffb5037d7746e5071d2f772948b3e'

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

require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Foreman < Formula
  homepage 'https://github.com/Indatus/foreman'
  url 'https://github.com/Indatus/foreman/raw/v1.0.0/foreman.phar'
  sha1 '787d7674f47faad1df9484bd106673c23827cf16'
  version '1.0.0'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "foreman.phar"
    sh = libexec + "foreman"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/foreman.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'foreman'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "foreman".

    You can read more about foreman by running:
      "brew home foreman".
    EOS
  end

end

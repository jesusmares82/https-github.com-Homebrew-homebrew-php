require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Boris < Formula
  homepage 'https://github.com/d11wtq/boris/'
  url      'https://github.com/d11wtq/boris/releases/download/v1.0.8/boris.phar'
  sha1     '69aeccda5d8b8dcc666b9f472c7ae33173660d26'
  version  '1.0.8'
  head     'https://github.com/d11wtq/boris.git'

  def install
    libexec.install "boris.phar"
    sh = libexec + "boris"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/boris.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system 'boris', '-h'
  end

  def caveats
    <<-EOS.undent
    Boris depends on the following PHP features:
      * PHP >= 5.3
      * The Readline functions
      * The PCNTL functions
      * The POSIX functions
    EOS
  end
end

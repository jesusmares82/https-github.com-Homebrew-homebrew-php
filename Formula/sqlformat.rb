require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Sqlformat < Formula
  homepage 'https://github.com/MattKetmo/sqlformat'
  url 'https://github.com/MattKetmo/sqlformat/releases/download/v1.0.0/sqlformat.phar'
  sha1 'a296e56160b23a48962cdb97a498c7f9574a23f7'
  version '1.0.0'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "sqlformat.phar"
    sh = libexec + "sqlformat"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/sqlformat.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "sqlformat"
  end
end

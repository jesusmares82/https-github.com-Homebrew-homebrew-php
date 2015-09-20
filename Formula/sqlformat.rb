require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Sqlformat < Formula
  desc "CLI adaptation of the SqlFormatter library"
  homepage "https://github.com/MattKetmo/sqlformat"
  url "https://github.com/MattKetmo/sqlformat/releases/download/v1.0.0/sqlformat.phar"
  version "1.0.0"
  sha256 "57eecf761142091424a96a651d537229edee686741f412c6b19201e3f3792914"

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

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Box < Formula
  homepage "http://box-project.org/"
  url "https://github.com/box-project/box2/releases/download/2.5.2/box-2.5.2.phar"
  sha256 "4df2f37906b5bbb124851d7b8359533b0a3bdd890c47ba14e82c4c07be22ce71"

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "box-#{version}.phar"
    (libexec/"box").write <<-EOS.undent
      #!/usr/bin/env bash
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/box-#{version}.phar $*
      EOS
    chmod 0755, (libexec/"box")
    bin.install_symlink (libexec/"box")
  end

  test do
    system "box", "--version"
  end
end

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Mondrian < Formula
  desc "Analyse and refactor highly coupled classes"
  homepage "https://trismegiste.github.io/Mondrian/"
  url "https://github.com/Trismegiste/Mondrian/raw/v1.3.3/bin/box/mondrian.phar"
  version "1.3.3"
  sha256 "8934447cd92e826a17f0056a27b3b98777a5e5126c29858919006551d861e340"

  depends_on PhpMetaRequirement
  depends_on PharRequirement
  depends_on "graphviz"

  def install
    libexec.install "mondrian.phar"
    sh = libexec + "mondrian"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/mondrian.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "mondrian --version".

    You can read more about mondrian by running:
      "brew home mondrian".
    EOS
  end

  test do
    system "mondrian", "--version"
  end
end

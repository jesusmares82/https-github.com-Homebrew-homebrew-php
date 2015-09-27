require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Mondrian < AbstractPhpPhar
  init
  desc "Analyse and refactor highly coupled classes"
  homepage "https://trismegiste.github.io/Mondrian/"
  url "https://github.com/Trismegiste/Mondrian/raw/v1.3.3/bin/box/mondrian.phar"
  version "1.3.3"
  sha256 "8934447cd92e826a17f0056a27b3b98777a5e5126c29858919006551d861e340"

  depends_on "graphviz"

  test do
    system "mondrian", "--version"
  end
end

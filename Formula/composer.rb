require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.1/composer.phar"
  sha256 "de069dae8c7bf01adedc925d3ac2358e5318a1b05580b001aa04e585fa55d8c0"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "45047cc42d33467e09a6ce22b128211da46ae44f4c91c6ca1af58863ee3cdfd0" => :el_capitan
    sha256 "08f84829facc6b0a8609b7913fd1c409c6261601a696fa767974f590f36a6bd7" => :yosemite
    sha256 "b8dbdd134e3311da1449e33a61220a136d18e8d2439f5a3baa498b967ba60651" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

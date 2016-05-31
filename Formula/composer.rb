require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.1.2/composer.phar"
  sha256 "7af2409080619e2ba98e78d7675710c23acf2ccf088d4439a4f79c33ed85c505"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "e331c75206fb9a44ae09f6dbed9b6f05b1babc02a7cd5e05180cc0d371384143" => :el_capitan
    sha256 "4784cfca64bee81ba58bbb9204086e0fbfa9bd2be0bf39f2d73445a41e927d1e" => :yosemite
    sha256 "89bd5f76585511ad9fb733927b167edebda7f1334dd5198fd1940e63959244f2" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

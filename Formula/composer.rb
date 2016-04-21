require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.2/composer.phar"
  sha256 "264673ccee900b22192605b8c74ecb77c45a5197347edacd142699866c478f4c"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "3a66057a0f78fdf017c4b08362be2b381fc90f4c88bde10ff911aa25821e8d18" => :el_capitan
    sha256 "942322f25c551726ddb3800a9300cee6ded091b7db31e180606aa3112c567bcd" => :yosemite
    sha256 "bd8e889bd3697b2823147cfff0c2ce5d50aff805930c0b706650991322e6cd50" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

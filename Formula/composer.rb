require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.0/composer.phar"
  sha256 "dc80131545ed7f7b1369ae058824587f0718892f6a84bd86cfb0f28ab5e39095"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "db969d984e7ac58c82e2729dfe0f1656ba8d68c00fb9388d8be1b6e85188c9ae" => :el_capitan
    sha256 "3861b491717dd7d0b43a4086153695e4fb86784deb0a6a0eae43c1ea61bba93b" => :yosemite
    sha256 "95456d18f0a07c0dddc1c87fbecc89cdad1a0b8b04610acd081cea88f16c531b" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

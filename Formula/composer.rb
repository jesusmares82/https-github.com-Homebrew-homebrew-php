require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.1/composer.phar"
  sha256 "c2e04040b807a8530e5c83de56bdaaf63a0f183f8fd449bbe6e41f660e647427"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "e2baaa146118e9ed3465d4d8e1ecee0ea484e4c28186e1605b32149227eb886c" => :el_capitan
    sha256 "b3213d25fb013f8bc6381e8be15964b17da50a7e5c0b8665d8a7210f94171138" => :yosemite
    sha256 "b3213d25fb013f8bc6381e8be15964b17da50a7e5c0b8665d8a7210f94171138" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

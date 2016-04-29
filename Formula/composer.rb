require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.3/composer.phar"
  sha256 "78c5c0e3f41dcd4d6ee532d9ae7e23afa33bdd409d8824dff026f3991d6ad70a"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "72fbd69e1f1d020b74ea2158dab7836e31c7ac574cc09899fd42a5444cc62fe7" => :el_capitan
    sha256 "85679b95e0cfacd87a1ba09cdeaac6956841e1d4f564bd6fed1405b477417463" => :yosemite
    sha256 "c0dc28779be4d6c0ea0b68eb0fdcc95bd048d2a6b7ffb1e440f1e14d2853bf2d" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

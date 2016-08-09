require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.5.0.phar"
  sha256 "b0ae66d41867d6ec38ba87651ec290165db318682968d2e5020c456677d8a003"

  bottle do
    cellar :any_skip_relocation
    sha256 "df9adb112b66c48b91527980925b470dea4b7b4ecb80274e2acf3f68642308d8" => :el_capitan
    sha256 "e91f5e586d9a2aefad1547a4b659982ae5b27ae3e27e915ab60796f55a7c410e" => :yosemite
    sha256 "ee56afecc44016aa205136bf94e96ef023538c5dcb126394e4da41dca1b9bd09" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end

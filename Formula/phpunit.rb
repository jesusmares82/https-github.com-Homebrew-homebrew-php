require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.4.1.phar"
  sha256 "431c65be707e32f93ba3cbccc3a2c8a9655732c750cdd9dc5b0f09bb7cc3ebf7"

  bottle do
    cellar :any_skip_relocation
    sha256 "cd811a1c6d0c69acbac924a27c0d393d86f01235362af91c162eb27668bdc218" => :high_sierra
    sha256 "4f2e0a4938b67482c02647a63954ab2e31f36e422b8b4ace20968caff9e1b944" => :sierra
    sha256 "4f2e0a4938b67482c02647a63954ab2e31f36e422b8b4ace20968caff9e1b944" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.2.8.phar"
  sha256 "160bbfaee74c5f91b04776da98ee176cf2b5bc5635e7abd19216c6f2883b5446"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9ccce3b3a394a11584daeb3de6c8d5930dfb065a0397180ad3fc8ab3389424d" => :el_capitan
    sha256 "842c0e13bd93e0926ceb499cfaa52d73f62e0043d05ee068e62ccd63b352b282" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end

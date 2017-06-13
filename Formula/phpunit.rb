require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.2.2.phar"
  sha256 "62eedccb119b86570e6c867cb89671e04da4694fb4c7595ffcde3142e51fbf79"

  bottle do
    cellar :any_skip_relocation
    sha256 "704cc5e6c4dc175686d197fc8f798a716cda37c238d1fa3b31be0bf8c48ca681" => :sierra
    sha256 "c52129ff6d482295948a9289015ac91d4f451d9df382b299fc7ccac70ad40b44" => :el_capitan
    sha256 "c52129ff6d482295948a9289015ac91d4f451d9df382b299fc7ccac70ad40b44" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end

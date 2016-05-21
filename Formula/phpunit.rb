require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.3.4.phar"
  sha256 "ce354a3722dd40f2af807e6ddc091646b7364b14f639a1fdd077e1c95f8ad859"

  bottle do
    cellar :any_skip_relocation
    sha256 "d2dd6ac35e99c62a8a4cac7895aad5334f3318efd280b60005dac238400e2c00" => :el_capitan
    sha256 "c4a026871ef7341eae9c81999b956d2fac7d7be82cc1304a29a1a317f7dd22ea" => :yosemite
    sha256 "73a62def02af831d02ff5a5271f474e3ce326540f7dd3598d715439d1f0d7af8" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end

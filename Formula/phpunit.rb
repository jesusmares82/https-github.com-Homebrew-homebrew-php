require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.2.1.phar"
  sha256 "b2fe8665f47624cd4805d0d4e739e1105cc9ff1127656a4ccdb50d2c105b66c2"

  bottle do
    cellar :any_skip_relocation
    sha256 "6142035e75bb83f02af8d33b81598ab85e0527d4b9f3bef3b127f44037d18f8f" => :el_capitan
    sha256 "87b12aafa7a2865bf5ea3a1c9b0ebee90db5308b6998bbc549cb2bb46064a2a4" => :yosemite
    sha256 "04840206e0cdc20906bca1191b9e5d68d571dbaede15f4cec22f9027ab3dfdae" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end

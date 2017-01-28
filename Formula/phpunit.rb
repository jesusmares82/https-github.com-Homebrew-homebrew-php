require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.9.phar"
  sha256 "67accba42c36746d6c71c437b073784002a7fc2c4a045c1928b7ee0fedcf13bd"

  bottle do
    cellar :any_skip_relocation
    sha256 "7a88426731cb41e2cfd3e239af123f670792a774d040dfb324a3a3a351e6c5d8" => :sierra
    sha256 "eb3e087370282b767af3d99bf86d6629eb5eda7afe1e0526b3dc77e3cc38bc14" => :el_capitan
    sha256 "eb3e087370282b767af3d99bf86d6629eb5eda7afe1e0526b3dc77e3cc38bc14" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end

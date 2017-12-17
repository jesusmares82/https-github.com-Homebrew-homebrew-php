require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.5.phar"
  sha256 "7b871b0726d40dc4d783c08f4051b400615b0d85f0a5e26c86b9a75be47c8da1"

  bottle do
    cellar :any_skip_relocation
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :high_sierra
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :sierra
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end

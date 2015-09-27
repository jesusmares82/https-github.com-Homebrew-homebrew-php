require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "http://getcomposer.org/download/1.0.0-alpha10/composer.phar"
  version "1.0.0-alpha10"
  sha256 "9f2c7d0364bc743bcde9cfe1fe84749e5ac38c46d47cf42966ce499135fd4628"
  head "https://getcomposer.org/composer.phar"

  test do
    system "composer", "--version"
  end
end

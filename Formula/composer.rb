require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "http://getcomposer.org/download/1.0.0-alpha10/composer.phar"
  version "1.0.0-alpha10"
  sha256 "9f2c7d0364bc743bcde9cfe1fe84749e5ac38c46d47cf42966ce499135fd4628"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "590d3fbe560aa13f69f31e4a106eae9b66d3bce29849d3c1fb0f68075154a4d2" => :el_capitan
    sha256 "299ab6a4c4644fdef9e98fa8e15e5575560d2efab3b2382407d9e21c14d66667" => :yosemite
    sha256 "8c86ddae5e4942c63e6193ba4c90c3bb9ef83d0bd5ff8dd1e639f672bdd087f1" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

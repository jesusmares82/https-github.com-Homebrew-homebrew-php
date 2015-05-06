require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-4.6.6.phar"
  sha256 "67c2225d2a1257aa230bf30431720d452314d3f465c766b82e8de20a24a65676"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha256 "d319ac9752c3f1fd6a2984b26e4a235e80c5c7fc97b53e2bc5a18ddefbf36807" => :yosemite
    sha256 "f03e4b351614011e19b39b7538fa0cc103fc3693120d2ce541a9b56d7188ea1e" => :mavericks
    sha256 "727fa894acdc9eb56aa61f4bf361cb4fb27ac01f0bdd7b4d729e73e4790bd041" => :mountain_lion
  end

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end

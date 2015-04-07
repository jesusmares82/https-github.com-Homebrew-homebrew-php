require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://phar.phpunit.de/phpunit-4.6.2.phar'
  sha1 'afa1021ee52a0ddae7d648ebbcd248998e480bd8'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha1 "b679109c8569b13469f45ea022462b98d0576657" => :yosemite
    sha1 "bdbf99ab174e1e0ecffcde91db8de1ea6f0acba9" => :mavericks
    sha1 "f16bc737fb24a20bcffdf309b81105c430abaa8c" => :mountain_lion
  end

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end

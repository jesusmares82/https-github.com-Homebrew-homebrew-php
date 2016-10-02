require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.5/codecept.phar"
  sha256 "73b0c02468d3aad7be2232473f4a9928767620070d6cc6194a3af023c2b0ea20"

  bottle do
    cellar :any_skip_relocation
    sha256 "6536dce57fcc3b23badbd8cf7fbc2b7f36903a637d6319afd65db03d925d358e" => :sierra
    sha256 "6536dce57fcc3b23badbd8cf7fbc2b7f36903a637d6319afd65db03d925d358e" => :el_capitan
    sha256 "6536dce57fcc3b23badbd8cf7fbc2b7f36903a637d6319afd65db03d925d358e" => :yosemite
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "codecept", "--version"
  end
end

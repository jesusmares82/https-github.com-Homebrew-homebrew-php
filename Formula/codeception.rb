require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.6/codecept.phar"
  sha256 "21ebede0380599dcf7d26a364de355e79d93f14f7acbb355c2ded094d5a57bb1"

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

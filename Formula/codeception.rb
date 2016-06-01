require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.9/codecept.phar"
  sha256 "096477a8722135ec137e0e485b15c48adad92cb197aa443aa3273196e5083eb6"

  bottle do
    cellar :any_skip_relocation
    sha256 "f3ece9192d447480389544e35aa06d802f0fba23244785cbf0111b722851abc7" => :el_capitan
    sha256 "ec411ae93509aebfe9c42d864843687b2642ab2bfb890ba7cba92612c40d798b" => :yosemite
    sha256 "3c87eb705d2200d9692f37e67b8280b2be8dce230a9d2f47ad5ceefc7dcd1b52" => :mavericks
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  def caveats; <<-EOS.undent
    To update your tests for 2.1.x check the "Upgrading" section:
    http://codeception.com/06-30-2015/codeception-2.1-is-here.html

    EOS
  end

  test do
    system "codecept", "--version"
  end
end

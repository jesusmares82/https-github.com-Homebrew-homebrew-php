require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phive < AbstractPhpPhar
  init
  desc "Installation and verification of phar distributed PHP applications"
  homepage "https://phar.io"
  url "https://github.com/phar-io/phive/releases/download/0.8.0/phive-0.8.0.phar"
  sha256 "e2682d3089863ebad64df650b1e9a2b74d99433c6e7f37be6433d62584e2b77b"
  head "https://phar.io/releases/phive.phar"

  bottle :unneeded

  def phar_bin
    "phive"
  end

  def phar_file
    "phive-#{version}.phar"
  end

  test do
    system bin/"phive", "version"
  end

  def phar_wrapper
    <<-EOS.undent
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      passthru("/usr/bin/env php -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end

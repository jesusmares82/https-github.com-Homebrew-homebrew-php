require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phive < AbstractPhpPhar
  init
  desc "Installation and verification of phar distributed PHP applications"
  homepage "https://phar.io"
  url "https://github.com/phar-io/phive/releases/download/0.7.2/phive-0.7.2.phar"
  sha256 "46fa1ada32350ebf7e579d078db1faec96aa5959436d912a4dc62cc0fde2e333"
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

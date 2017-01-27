require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.3.2/composer.phar"
  sha256 "6a4f761aa34bb69fca86bc411a5e9836ca8246f0fcd29f3804b174fee9fb0569"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "f109359f75dea1aeb0330b5da16c25aa1af6d51148b481c9312e0e3bf675bcc4" => :sierra
    sha256 "a7ea50fbd27c7cdcccd97131325418895b97d0e6b03d6d5d72260c877a8b0852" => :el_capitan
    sha256 "a7ea50fbd27c7cdcccd97131325418895b97d0e6b03d6d5d72260c877a8b0852" => :yosemite
  end

  test do
    system "#{bin}/composer", "--version"
  end

  # The default behavior is to create a shell script that invokes the phar file.
  # Other tools, at least Ansible, expect the composer executable to be a PHP
  # script, so override this method. See
  # https://github.com/Homebrew/homebrew-php/issues/3590
  def phar_wrapper
    <<-EOS.undent
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      $arg_string .= preg_match('/--(no-)?ansi/', $arg_string) ? '' : ' --ansi';
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end

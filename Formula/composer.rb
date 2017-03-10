require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.4.1/composer.phar"
  sha256 "abd277cc3453be980bb48cbffe9d1f7422ca1ef4bc0b7d035fda87cea4d55cbc"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "22f5ec8b978e9edf5ba70407b2757a9a4ceb1bd5db78a85aceb15bf66e78a888" => :sierra
    sha256 "22f5ec8b978e9edf5ba70407b2757a9a4ceb1bd5db78a85aceb15bf66e78a888" => :el_capitan
    sha256 "22f5ec8b978e9edf5ba70407b2757a9a4ceb1bd5db78a85aceb15bf66e78a888" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.4/composer.phar"
  sha256 "3c900579659b79a4e528722e35bd160c86090e370e9cb41cc07c7a22c674c657"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5b9d765b8241ac96a7ccb12cda8d81f71e1a9a258a36c54abbdf3192a847eeb" => :sierra
    sha256 "f5b9d765b8241ac96a7ccb12cda8d81f71e1a9a258a36c54abbdf3192a847eeb" => :el_capitan
    sha256 "f5b9d765b8241ac96a7ccb12cda8d81f71e1a9a258a36c54abbdf3192a847eeb" => :yosemite
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

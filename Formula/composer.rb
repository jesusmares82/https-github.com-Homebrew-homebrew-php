require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.5.6/composer.phar"
  sha256 "25e75d72818c4f1d46b3ae47a8deaaf4ef25c87198329d4a6ee53601b00459e5"
  head "https://getcomposer.org/composer.phar"

  devel do
    url "https://getcomposer.org/download/1.6.0-RC/composer.phar"
    sha256 "fbbc2a8085331976ff08a7920230a30e38b847b1f3bfbae54e1c0ea6676b2fae"
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "f936d39b1d1ce8ba86cf03ad2a7c472a08c9bd4986e62f932e4306193081b393" => :high_sierra
    sha256 "f936d39b1d1ce8ba86cf03ad2a7c472a08c9bd4986e62f932e4306193081b393" => :sierra
    sha256 "f936d39b1d1ce8ba86cf03ad2a7c472a08c9bd4986e62f932e4306193081b393" => :el_capitan
  end

  depends_on PharRequirement

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
      $arg_prefix = preg_match('/--(no-)?ansi/', $arg_string) ? '' : '--ansi ';
      $arg_string = $arg_prefix . $arg_string;
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end

  def caveats
    <<-EOS
      composer no longer depends on the homebrew php Formulas since the last couple of macOS releases
      contains a php version compatible with composer. If this has been part of your workflow
      previously then please make the appropriate changes and `brew install php71` or other appropriate
      Homebrew PHP version.
    EOS
  end
end

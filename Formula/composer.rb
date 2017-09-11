require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.5.2/composer.phar"
  sha256 "c0a5519c768ef854913206d45bd360efc2eb4a3e6eb1e1c7d0a4b5e0d3bbb31f"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "f6e4ad1c9d01449245d683e255d9cd4854677d236f80770a8bb15903a1e3e6cd" => :sierra
    sha256 "f6e4ad1c9d01449245d683e255d9cd4854677d236f80770a8bb15903a1e3e6cd" => :el_capitan
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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.4.1/composer.phar"
  sha256 "abd277cc3453be980bb48cbffe9d1f7422ca1ef4bc0b7d035fda87cea4d55cbc"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "28bbb31533b274b651bd8dcb21c5fa258cec41d5e0448bca41bb72975fbecfbc" => :sierra
    sha256 "f21ed141cb25d262a7c3baa87b72a8bbd2ff6abef37af76a73e27559d42d7726" => :el_capitan
    sha256 "f21ed141cb25d262a7c3baa87b72a8bbd2ff6abef37af76a73e27559d42d7726" => :yosemite
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
      $arg_string .= preg_match('/--(no-)?ansi/', $arg_string) ? '' : ' --ansi';
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end

  def caveats
    caveats = <<-EOS
    composer no longer depends on the homebrew php Formulas since the last couple of macOS releases
    contains a php version compatible with composer. If this has been part of your workflow
    previously then please make the appropriate changes and `brew install php71` or other appropriate
    Homebrew PHP version.
    EOS
  end
end

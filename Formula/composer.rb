require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.3/composer.phar"
  sha256 "3378c1422bffa09c29714aefd3240b963ce7731e71ae8894d9c7991101325cb8"
  revision 1
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "dfc1b1d3c8e91bc84729f2ab2bb34d7798fabcbd98391e41fbd957e9064300a1" => :sierra
    sha256 "dfc1b1d3c8e91bc84729f2ab2bb34d7798fabcbd98391e41fbd957e9064300a1" => :el_capitan
    sha256 "dfc1b1d3c8e91bc84729f2ab2bb34d7798fabcbd98391e41fbd957e9064300a1" => :yosemite
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

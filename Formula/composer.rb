require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.1/composer.phar"
  sha256 "c2e04040b807a8530e5c83de56bdaaf63a0f183f8fd449bbe6e41f660e647427"
  head "https://getcomposer.org/composer.phar"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "57f272b2cc634462511ccc0b1d5b34ebc95c6347e74ed360c624dc2d3f140f44" => :sierra
    sha256 "57f272b2cc634462511ccc0b1d5b34ebc95c6347e74ed360c624dc2d3f140f44" => :el_capitan
    sha256 "57f272b2cc634462511ccc0b1d5b34ebc95c6347e74ed360c624dc2d3f140f44" => :yosemite
  end

  test do
    system "composer", "--version"
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
      $arg_string = implode(' ', $argv);
      $arg_string .= preg_match('/--(no-)?ansi/', $arg_string) ? '' : ' --ansi';
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      return $return_var;
    EOS
  end
end

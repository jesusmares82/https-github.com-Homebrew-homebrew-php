require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.2/composer.phar"
  sha256 "c6ae4e099351233f5f82ade9738475eec6587aadf9ffe66fec4c350b329fbb32"
  revision 1
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "5fc73dc680d53d4898f8ef7b6f254ce77a54a01ec5fd967b26df3d13a648d8b6" => :sierra
    sha256 "5fc73dc680d53d4898f8ef7b6f254ce77a54a01ec5fd967b26df3d13a648d8b6" => :el_capitan
    sha256 "5fc73dc680d53d4898f8ef7b6f254ce77a54a01ec5fd967b26df3d13a648d8b6" => :yosemite
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
      $arg_string = implode(' ', $argv);
      $arg_string .= preg_match('/--(no-)?ansi/', $arg_string) ? '' : ' --ansi';
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end

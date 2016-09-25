require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.2.1/composer.phar"
  sha256 "c2e04040b807a8530e5c83de56bdaaf63a0f183f8fd449bbe6e41f660e647427"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "2d57f07374a62a5de06915e4c0f4c840826d0e31b9c901238cbaca22a5a9f9aa" => :sierra
    sha256 "2d57f07374a62a5de06915e4c0f4c840826d0e31b9c901238cbaca22a5a9f9aa" => :el_capitan
    sha256 "2d57f07374a62a5de06915e4c0f4c840826d0e31b9c901238cbaca22a5a9f9aa" => :yosemite
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
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      return $return_var;
    EOS
  end
end

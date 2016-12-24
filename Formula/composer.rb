require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.3.0/composer.phar"
  sha256 "92ce3125cae2015c5c1f7657e78a6e239ff47b714eb1418288abf45d55f3be27"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "80a1aa34f374451eb41e191b35324b608782885eda1ea75eec817deed0420a01" => :sierra
    sha256 "e922f26368316a63bfe286829d748c1ade48bc608f3cfeb30e26866785a41ccd" => :el_capitan
    sha256 "c8b87211d540a959f8ce09059798d3785c1e5a037535a209278c21534b8572a0" => :yosemite
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

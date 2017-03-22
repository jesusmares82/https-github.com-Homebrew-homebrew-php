require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class ComposerAT12 < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.2.4/composer.phar"
  sha256 "3c900579659b79a4e528722e35bd160c86090e370e9cb41cc07c7a22c674c657"

  bottle do
    cellar :any_skip_relocation
    sha256 "802d1a7f54882a23efe2c60edce9d2ac45b73d7baf957781f0ab13c38963c3d4" => :sierra
    sha256 "802d1a7f54882a23efe2c60edce9d2ac45b73d7baf957781f0ab13c38963c3d4" => :el_capitan
    sha256 "802d1a7f54882a23efe2c60edce9d2ac45b73d7baf957781f0ab13c38963c3d4" => :yosemite
  end

  def phar_file
    "composer.phar"
  end

  def phar_bin
    "composer-1.2"
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
    <<-EOT.undent
      This installs the older composer version #{version} as '#{phar_bin}'.
    EOT
  end

  test do
    system "#{bin}/composer-1.2", "--version"
  end
end

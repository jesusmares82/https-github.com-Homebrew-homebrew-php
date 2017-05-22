require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.4.2/composer.phar"
  sha256 "6b1945c3ee477f12be508a5bb41a5025d57de5510bcf94855ae6a4d59f3d86f4"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "7fbd2ae93116d1a88ede4a2019d1eeace7c949779250148db99aaaf1a7d3acd6" => :sierra
    sha256 "abf138e6ab399511bd9919eeced56dd15ff35704006c2b9b38c38fa3ebef2427" => :el_capitan
    sha256 "abf138e6ab399511bd9919eeced56dd15ff35704006c2b9b38c38fa3ebef2427" => :yosemite
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
    <<-EOS
      composer no longer depends on the homebrew php Formulas since the last couple of macOS releases
      contains a php version compatible with composer. If this has been part of your workflow
      previously then please make the appropriate changes and `brew install php71` or other appropriate
      Homebrew PHP version.
    EOS
  end
end

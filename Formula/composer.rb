require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.1.1/composer.phar"
  sha256 "7f26efee06de5a1a061b6b1e330f5acc9ee69976d1551118c45b21f358cbc332"
  revision 1
  head "https://getcomposer.org/composer.phar"

  def phar_wrapper
    <<-EOS.undent
      #!/usr/bin/env bash

      TEMP_PATH="$( mktemp -t php-no-debug )"
      FILES="$( /usr/bin/env php -r 'echo php_ini_loaded_file() . "\n" . str_replace(",","", php_ini_scanned_files());' )"
      cat $FILES | sed '/xdebug/d' > "$TEMP_PATH"

      /usr/bin/env php -n -c "$TEMP_PATH" -d detect_unicode=Off #{libexec}/#{@real_phar_file} "$@"

      rm -f "$TEMP_PATH"
    EOS
  end

  bottle do
  end

  test do
    system "composer", "--version"
  end
end

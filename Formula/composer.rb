require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.1.1/composer.phar"
  sha256 "7f26efee06de5a1a061b6b1e330f5acc9ee69976d1551118c45b21f358cbc332"
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
    cellar :any_skip_relocation
    sha256 "dd4a75805b9d1ca2dfa6c19983886f4468da39c18f21f315e588719c53f2216e" => :el_capitan
    sha256 "882c97af3224a26e19f5b85c7c9d454d3ed7eefa6c19e434707b58a11b18fb65" => :yosemite
    sha256 "fdd3f88c4748268f5a20d4a614c3d96b8a247b745a90426c6a991ab7ac21a2ba" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

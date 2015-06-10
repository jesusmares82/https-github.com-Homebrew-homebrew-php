require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-building-requirement", __FILE__)

class PhpCsFixer < Formula
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.8.1.tar.gz"
  sha256 "aa07bd030d93db0f0aff7d566b69095eb91eae74a736fb4f742f4a45a81c49d9"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  depends_on PhpMetaRequirement
  depends_on PharRequirement
  depends_on PharBuildingRequirement
  depends_on "composer"
  depends_on "php53" if Formula['php53'].linked_keg.exist?
  depends_on "php54" if Formula['php54'].linked_keg.exist?
  depends_on "php55" if Formula['php55'].linked_keg.exist?
  depends_on "php56" if Formula['php56'].linked_keg.exist?

  def install
    File.open("genphar.php", "w") {|f| f.write(phar_stub) }

    [
      "mkdir -p src",
      "rsync -a --exclude 'src' . src/",
      "cd src && /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off  #{Formula['composer'].libexec}/composer.phar install",
      "cd src && sed -i '' '1d' php-cs-fixer",
      "php -f genphar.php",
    ].each { |c| `#{c}` }

    libexec.install "php-cs-fixer.phar"
    sh = libexec + "php-cs-fixer"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/php-cs-fixer.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "php-cs-fixer", "--version"
  end

  def phar_stub
    <<-EOS.undent
      <?php
      $stub =<<<STUB
      <?php
      /** This was auto-built from source (https://github.com/fabpot/PHP-CS-Fixer) via Homebrew **/
      Phar::mapPhar('php-cs-fixer.phar'); require 'phar://php-cs-fixer.phar/php-cs-fixer'; __HALT_COMPILER(); ?>";
      STUB;
      $phar = new Phar('php-cs-fixer.phar');
      $phar->setAlias('php-cs-fixer.phar');
      $phar->buildFromDirectory('src');
      $phar->setStub($stub);
    EOS
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "php-cs-fixer --version".

    You can read more about php-cs-fixer by running:
      "brew home php-cs-fixer".
    EOS
  end
end

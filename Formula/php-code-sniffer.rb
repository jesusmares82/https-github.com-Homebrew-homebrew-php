require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)

class PhpCodeSniffer < Formula
  homepage 'http://pear.php.net/package/PHP_CodeSniffer'
  url 'http://download.pear.php.net/package/PHP_CodeSniffer-1.5.1.tgz'
  sha1 'a68b66cc1a88b7f5359270ab72292fff33587b00'

  depends_on PhpMetaRequirement

  def phpcs_standards
    etc+name+'Standards'
  end

  def phpcs_script_name
    'phpcs'
  end

  def install
    prefix.install Dir["PHP_CodeSniffer-#{version}/*"]
    (libexec+phpcs_script_name).write <<-EOS.undent
      #!/bin/sh
      /usr/bin/env php "#{prefix}/scripts/phpcs" "$@"
    EOS
    chmod 0755, libexec+phpcs_script_name
    bin.install_symlink libexec+phpcs_script_name

    # Create a place for other formulas to link their standards.
    phpcs_standards.mkpath
    system bin+phpcs_script_name, '--config-set', 'installed_paths', phpcs_standards
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:

      #{phpcs_script_name} --version

    You can read more about phpcs by running:

      brew home #{name}

    EOS
  end
end




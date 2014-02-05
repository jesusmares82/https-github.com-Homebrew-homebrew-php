require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)

class PhpCodeSniffer < Formula
  homepage 'http://pear.php.net/package/PHP_CodeSniffer'
  url 'http://download.pear.php.net/package/PHP_CodeSniffer-1.5.2.tgz'
  sha1 '0b804d3645592b29ddc8a193a9c288e613e22a49'

  devel do
    url 'http://download.pear.php.net/package/PHP_CodeSniffer-2.0.0a1.tgz'
    sha1 'd7f9dd747aeafc0750e471a7c3c35a4b640427e8'
  end

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
    Install the alpha release of PHP CodeSniffer with the --devel option.

    Verify your installation by running:

      #{phpcs_script_name} --version

    You can read more about phpcs by running:

      brew home #{name}

    EOS
  end
end

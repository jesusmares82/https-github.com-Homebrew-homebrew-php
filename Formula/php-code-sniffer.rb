require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCodeSniffer < Formula
  homepage 'http://pear.php.net/package/PHP_CodeSniffer'
  url 'http://download.pear.php.net/package/PHP_CodeSniffer-1.5.3.tgz'
  sha1 'b5006f4f11a564c9de9660967210b606637fa145'

  devel do
    url 'http://download.pear.php.net/package/PHP_CodeSniffer-2.0.0a2.tgz'
    sha1 '1db15c6ae2387a4dea3589d9192b010430f3300a'
  end

  depends_on PhpMetaRequirement

  def phpcs_standards
    etc+name+'Standards'
  end

  def phpcs_script_name
    'phpcs'
  end

  def phpcbf_script_name
    'phpcbf'
  end

  def install
    prefix.install Dir["PHP_CodeSniffer-#{version}/*"]
    (libexec+phpcs_script_name).write <<-EOS.undent
      #!/bin/sh
      /usr/bin/env php "#{prefix}/scripts/phpcs" "$@"
    EOS
    chmod 0755, libexec+phpcs_script_name
    bin.install_symlink libexec+phpcs_script_name

    # The alpha release comes with "PHP Code Beautifier and Fixer".
    # See https://github.com/squizlabs/PHP_CodeSniffer/wiki/Fixing-Errors-Automatically
    if build.devel?
      (libexec+phpcbf_script_name).write <<-EOS.undent
        #!/bin/sh
        /usr/bin/env php "#{prefix}/scripts/phpcbf" "$@"
        EOS
      chmod 0755, libexec+phpcbf_script_name
      bin.install_symlink libexec+phpcbf_script_name
    end

    # Make sure the config file is preserved on upgrades. We do that
    # be substituting @data_dir@ with #{etc} and making sure the
    # folder #{etc}/PHP_CodeSniffer exists.
    (etc+'PHP_CodeSniffer').mkpath
    inreplace "#{prefix}/CodeSniffer.php" do |s|
      s.gsub! /@data_dir@/, "#{etc}"
    end

    # Create a place for other formulas to link their standards.
    phpcs_standards.mkpath

    # Configure installed_paths, but don't overwrite it if already set
    # (preserve config).
    `#{bin+phpcs_script_name} --config-show | grep -q installed_paths`
    unless $?.to_i == 0
      system bin+phpcs_script_name, '--config-set', 'installed_paths', phpcs_standards
    end

    # Fix shebang line of phpcs-svn-pre-commit script.
    # See https://github.com/squizlabs/PHP_CodeSniffer/wiki/Using-the-SVN-pre-commit-Hook
    inreplace "#{prefix}/scripts/phpcs-svn-pre-commit" do |s|
      s.gsub! /^#!@php_bin@/, "#!#{HOMEBREW_PREFIX}/bin/php"
    end
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

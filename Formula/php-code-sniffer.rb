require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCodeSniffer < Formula
  desc "Check coding standards in PHP, JavaScript and CSS"
  homepage "https://pear.php.net/package/PHP_CodeSniffer"
  url "http://download.pear.php.net/package/PHP_CodeSniffer-3.0.1.tgz"
  sha256 "46b2ab302832809801bd384c2da384db783367dad47fb11faf5ca7e733348380"

  bottle do
    cellar :any_skip_relocation
    sha256 "64f2697bc1b20fc7617c324c014aa4facf3daaad432eb2e08d46c1ad1faea74f" => :sierra
    sha256 "ff48e96b3190081a65b9cf5df14b05b15f8d4dac0aa16f2b53876cd8e5277e19" => :el_capitan
    sha256 "ff48e96b3190081a65b9cf5df14b05b15f8d4dac0aa16f2b53876cd8e5277e19" => :yosemite
  end

  depends_on PhpMetaRequirement

  def phpcs_standards
    etc+name+"Standards"
  end

  def phpcs_script_name
    "phpcs"
  end

  def phpcbf_script_name
    "phpcbf"
  end

  def install
    prefix.install Dir["PHP_CodeSniffer-#{version}/*"]

    if File.symlink? libexec+phpcs_script_name
      File.delete libexec+phpcs_script_name
    end
    libexec.install_symlink prefix+"bin"+phpcs_script_name

    if File.symlink? libexec+phpcbf_script_name
      File.delete libexec+phpcbf_script_name
    end
    libexec.install_symlink prefix+"bin"+phpcbf_script_name

    # Remove Windows batch files
    File.delete bin+"phpcbf.bat"
    File.delete bin+"phpcs.bat"

    # Make sure the config file is preserved on upgrades. We do that
    # be substituting @data_dir@ with #{etc} and making sure the
    # folder #{etc}/PHP_CodeSniffer exists.
    if File.exist?(prefix+"CodeSniffer.conf")
      (etc+"PHP_CodeSniffer").mkpath
      inreplace "#{prefix}/CodeSniffer.conf", /@data_dir@/, etc
    end

    # Create a place for other formulas to link their standards.
    phpcs_standards.mkpath

    # Configure installed_paths, but don't overwrite it if already set
    # (preserve config).
    `#{bin+phpcs_script_name} --config-show | grep -q installed_paths`
    unless $CHILD_STATUS.to_i.zero?
      system bin+phpcs_script_name, "--config-set", "installed_paths", phpcs_standards
    end
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:

      #{phpcs_script_name} --version

    You can read more about phpcs by running:

      brew home #{name}

    Sniffs must be upgraded to be compatible with version 3.0

      https://github.com/squizlabs/PHP_CodeSniffer/wiki/Version-3.0-Upgrade-Guide

    EOS
  end

  test do
    (testpath/"test.php").write <<-EOS.undent
      <?php
      echo "foo"."bar"
    EOS
    system bin+phpcs_script_name, "--standard=Zend", "test.php"
    system "#{bin}/#{phpcs_script_name} --standard=PEAR --report=emacs test.php | grep -q 'error - Missing file doc comment'"
  end
end

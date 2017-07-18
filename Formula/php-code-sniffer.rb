require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCodeSniffer < Formula
  desc "Check coding standards in PHP, JavaScript and CSS"
  homepage "https://pear.php.net/package/PHP_CodeSniffer"
  url "http://download.pear.php.net/package/PHP_CodeSniffer-3.0.2.tgz"
  sha256 "782403840a46b24a8055889ca71f77046762ac7ed74f4aec8d2d95c7abf4b62b"

  bottle do
    cellar :any_skip_relocation
    sha256 "6f8906b2e856ec0f0ea1ef7882cf399a568a916cfec80b1ae3ac99fd9ea4b0bb" => :sierra
    sha256 "6f8906b2e856ec0f0ea1ef7882cf399a568a916cfec80b1ae3ac99fd9ea4b0bb" => :el_capitan
    sha256 "6f8906b2e856ec0f0ea1ef7882cf399a568a916cfec80b1ae3ac99fd9ea4b0bb" => :yosemite
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

require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class DrupalCodeSniffer < Formula
  desc "Checks Drupal code against coding standards"
  homepage "https://drupal.org/project/coder"
  url "http://ftp.drupal.org/files/projects/coder-8.x-2.7.tar.gz"
  version "8.x-2.7"
  sha256 "849e297964b99980e12031ae7c55ddbef410cbe88c74a3e4e2e7b2c43b100a19"
  head "http://git.drupal.org/project/coder.git", :branch => "8.x-2.x"

  bottle do
    cellar :any_skip_relocation
    sha256 "1d6f7adf6ebfc77f5cc38e5940e2891174378f462659a60ac1ed0d8954dd15b5" => :el_capitan
    sha256 "4de6582cb4a8834471292120a5482c7f44bbb838e46f104d6b5aa3abf596b0f0" => :yosemite
    sha256 "39d9d63bd3e3ac061f1435bf55763e686b9053da93ceeec5bca81a9a11775909" => :mavericks
  end

  option "without-drush-command", "Don't install drush command"
  option "without-drupalpractice-standard", "Don't install DrupalPractice standard"

  depends_on "drush" if build.with? "drush-command"
  depends_on "php-code-sniffer"
  depends_on PhpMetaRequirement

  def phpcs_standards
    Formula["php-code-sniffer"].phpcs_standards
  end

  def drupal_standard_name
    "Drupal"
  end

  def drupalpractice_standard_name
    "DrupalPractice"
  end

  def drush_commands
    HOMEBREW_PREFIX+"share"+"drush"+"commands"
  end

  def install
    prefix.install "coder_sniffer"
  end

  def post_install
    # Link Drupal Coder Sniffer into PHPCS standards.
    phpcs_standards.mkpath
    if File.symlink? phpcs_standards+drupal_standard_name
      File.delete phpcs_standards+drupal_standard_name
    end
    phpcs_standards.install_symlink prefix+"coder_sniffer"+drupal_standard_name

    # Link DrupalPractice Sniffer into PHPCS standards if not disabled.
    if build.with? "drupalpractice-standard"
      phpcs_standards.mkpath
      if File.symlink? phpcs_standards+drupalpractice_standard_name
        File.delete phpcs_standards+drupalpractice_standard_name
      end
      phpcs_standards.install_symlink prefix+"coder_sniffer"+drupalpractice_standard_name
    end

    # Link Drupal Coder Sniffer into /usr/local/share/drush/commands
    # for integration with Drush.
    if build.with? "drush-command"
      drush_commands.mkpath
      if File.symlink? drush_commands+name
        File.delete drush_commands+name
      end
      drush_commands.install_symlink prefix+"coder_sniffer" => name
    end
  end

  def caveats
    s = ""
    s += <<-EOS.undent
    Drupal Coder Sniffer is linked to "#{phpcs_standards+drupal_standard_name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      #{Formula["php-code-sniffer"].phpcs_script_name} -i

    EOS

    if build.with? "drush-command"
      s += <<-EOS.undent
          Drupal Coder Sniffer is installed as a drush command in "#{drush_commands+name}".

          You can verify whether Drush has discovered the standard by running:

            drush drupalcs --help
        EOS
    end

    s
  end

  test do
    system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupal_standard_name}"
    if build.with? "drupalpractice-standard"
      system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupalpractice_standard_name}"
    end
    if build.with? "drush-command"
      system "drush", "drupalcs", "--help"
    end
  end
end

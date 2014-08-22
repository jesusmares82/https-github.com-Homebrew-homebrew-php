require "formula"

class DrupalPracticeSniffer < Formula
  homepage "https://drupal.org/project/drupalpractice"
  version "7.x-1.0"
  url "https://github.com/klausi/drupalpractice/archive/#{version}.tar.gz"
  head "https://github.com/klausi/drupalpractice.git", :branch => "7.x-1.x"
  sha1 "21d465fd48a126ee6e14417d4576714fb92be73a"

  depends_on "homebrew/php/php-code-sniffer"
  depends_on "homebrew/php/drupal-code-sniffer"

  def phpcs_standards
    Formula["php-code-sniffer"].phpcs_standards
  end

  def drupal_standard_name
    "DrupalPractice"
  end

  def drush_commands
    HOMEBREW_PREFIX+"share"+"drush"+"commands"
  end

  def install
    # Because the standard gets installed with symlinks in the
    # Standards path we also need to provide a symlink to Drupal Coder
    # Sniffer inside our own prefix. Otherwise PHP Code Sniffer will
    # not be able to find classes from Drupal Coder Sniffer which
    # DrupalPractice Sniffer depends upon.
    prefix.install_symlink Formula["drupal-code-sniffer"].opt_prefix+"coder_sniffer"+"Drupal"

    prefix.install "DrupalPractice"

    # Link DrupalPractice Sniffer into PHPCS standards.
    phpcs_standards.mkpath
    if File.symlink? phpcs_standards+drupal_standard_name
      File.delete phpcs_standards+drupal_standard_name
    end
    phpcs_standards.install_symlink prefix+drupal_standard_name
  end

  def caveats; <<-EOS.undent
    DrupalPractice Sniffer is linked to "#{phpcs_standards+drupal_standard_name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      #{Formula["php-code-sniffer"].phpcs_script_name} -i

    EOS
  end
end

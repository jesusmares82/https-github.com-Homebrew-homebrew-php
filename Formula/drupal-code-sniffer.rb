require 'formula'

class DrupalCodeSniffer < Formula
  homepage 'https://drupal.org/project/coder'
  version '7.x-2.1'
  url "http://ftp.drupal.org/files/projects/coder-#{version}.tar.gz"
  head 'http://git.drupal.org/project/coder.git', :branch => '7.x-2.x'
  sha1 '61a154980d049de98d95c6efc83f491593a0e71d'

  depends_on 'php-code-sniffer'

  def phpcs_standards
    etc+'php-code-sniffer'+'Standards'
  end

  def drupal_standard_name
    'Drupal'
  end

  def drush_commands
    HOMEBREW_PREFIX+'share'+'drush'+'commands'
  end

  def install
    prefix.install 'coder_sniffer'

    # Link Drupal Coder Sniffer into PHPCS standards.
    phpcs_standards.mkpath
    if File.symlink? phpcs_standards+drupal_standard_name
      File.delete phpcs_standards+drupal_standard_name
    end
    phpcs_standards.install_symlink prefix+'coder_sniffer'+drupal_standard_name

    # Link Drupal Coder Sniffer into /usr/local/share/drush/commands
    # for integration with Drush.
    drush_commands.mkpath
    if File.symlink? drush_commands+name
      File.delete drush_commands+name
    end
    drush_commands.install_symlink prefix+'coder_sniffer' => name
  end

  def caveats; <<-EOS.undent
    Drupal Coder Sniffer is linked to "#{phpcs_standards+drupal_standard_name}"
    and to "#{drush_commands+name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      phpcs -i

    To have Drush discover the standard either add the following to drushrc.php:

      $options['include'][] = '#{drush_commands}';

    Or add this to, i.e., your ~/.profile:

      export SHARE_PREFIX="$(brew --prefix)"

    If https://github.com/Homebrew/homebrew/pull/25245 is accepted Drush will
    recognize it automatically.

    You can verify whether Drush has discovered the standard by running:

      drush drupalcs --help

    EOS
  end
end

require 'formula'

class DrupalCodeSniffer < Formula
  homepage 'https://drupal.org/project/coder'
  version '7.x-2.2'
  url "http://ftp.drupal.org/files/projects/coder-#{version}.tar.gz"
  head 'http://git.drupal.org/project/coder.git', :branch => '7.x-2.x'
  sha1 '9d3591f1035c9b0cd2d406d83a9071f94b826e09'

  option 'without-drush-command', "Don't install drush command"

  depends_on 'php-code-sniffer'

  def phpcs_standards
    Formula['php-code-sniffer'].phpcs_standards
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
    if build.with? 'drush-command'
      drush_commands.mkpath
      if File.symlink? drush_commands+name
        File.delete drush_commands+name
      end
      drush_commands.install_symlink prefix+'coder_sniffer' => name
    end
  end

  def caveats;
    s = ""
    s += <<-EOS.undent
    Drupal Coder Sniffer is linked to "#{phpcs_standards+drupal_standard_name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      #{Formula['php-code-sniffer'].phpcs_script_name} -i

    EOS

    if build.with? 'drush-command'
          s += <<-EOS.undent
          Drupal Coder Sniffer is installed as a drush command in "#{drush_commands+name}".

          You can verify whether Drush has discovered the standard by running:

            drush drupalcs --help
        EOS
    end

    return s
  end
end

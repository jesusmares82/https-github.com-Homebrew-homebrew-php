require 'formula'

class DrupalCodeSniffer < Formula
  homepage 'https://drupal.org/project/coder'
  url 'http://ftp.drupal.org/files/projects/coder-7.x-2.1.tar.gz'
  head 'http://git.drupal.org/project/coder.git', :branch => '7.x-2.x'
  version '7.x-2.1'
  sha1 '61a154980d049de98d95c6efc83f491593a0e71d'

  depends_on 'php-code-sniffer'

  def install
    prefix.install 'coder_sniffer/Drupal'

    # Link Drupal Coder Sniffer into PHPCS standards.
    standards = etc/'php-code-sniffer/Standards'
    (standards).mkpath
    if File.symlink? standards/'Drupal'
      File.delete standards/'Drupal'
    end
    (standards).install_symlink prefix/'Drupal'
  end

  def caveats; <<-EOS.undent
    Drupal Coder Sniffer has been installed into #{etc}/php-code-sniffer/Drupal

    You can verify whether PHP Code Sniffer has detected the standard by running:
      "phpcs -i".

    EOS
  end
end




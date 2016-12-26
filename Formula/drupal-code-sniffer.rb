require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class DrupalCodeSniffer < Formula
  desc "Checks Drupal code against coding standards"
  homepage "https://drupal.org/project/coder"
  url "http://ftp.drupal.org/files/projects/coder-8.x-2.10.tar.gz"
  version "8.x-2.10"
  sha256 "284fe865de904fdcbb512211ba8e18b78c79799868634cca8c7307c4f6902209"
  head "http://git.drupal.org/project/coder.git", :branch => "8.x-2.x"

  bottle do
    cellar :any_skip_relocation
    sha256 "b46b43237469637f1bef1f9cf3684f49f77e228e603f2db2dfea5be98a410cb4" => :sierra
    sha256 "1d6f7adf6ebfc77f5cc38e5940e2891174378f462659a60ac1ed0d8954dd15b5" => :el_capitan
    sha256 "4de6582cb4a8834471292120a5482c7f44bbb838e46f104d6b5aa3abf596b0f0" => :yosemite
    sha256 "39d9d63bd3e3ac061f1435bf55763e686b9053da93ceeec5bca81a9a11775909" => :mavericks
  end

  option "without-drupalpractice-standard", "Don't install DrupalPractice standard"

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
  end

  def caveats
    <<-EOS.undent
    Drupal Coder Sniffer is linked to "#{phpcs_standards+drupal_standard_name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      #{Formula["php-code-sniffer"].phpcs_script_name} -i

    EOS
  end

  test do
    system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupal_standard_name}"
    if build.with? "drupalpractice-standard"
      system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupalpractice_standard_name}"
    end
  end
end

require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.3.tar.gz"
  sha256 "cf0afca4d22998f83640a681f9b3159021f424e9363afadc1c4de04b60aab19a"

  bottle do
    cellar :any_skip_relocation
    sha256 "54adcaf6c0849b512cc80a6cb41faeb26d157bddfc161a1cc8f2cddc6c5c726c" => :el_capitan
    sha256 "18850cb98c63a56e2374e195e748f539b5b04cc67797483c020a8029a82c09ac" => :yosemite
    sha256 "48334cff2c7153e57e8c04189fcddea402307128fd00f8eb55e8278dbac7c446" => :mavericks
  end

  head do
    url "https://github.com/drush-ops/drush.git"
  end

  depends_on PhpMetaRequirement
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?

  def install
    composer_install

    prefix.install_metafiles
    File.delete "drush.bat"
    libexec.install Dir["*"]
    (bin+"drush").write <<-EOS.undent
      #!/bin/sh

      export ETC_PREFIX=${ETC_PREFIX:=#{HOMEBREW_PREFIX}}
      export SHARE_PREFIX=${SHARE_PREFIX:=#{HOMEBREW_PREFIX}}

      exec "#{libexec}/drush" "$@"
    EOS
    bash_completion.install libexec/"drush.complete.sh" => "drush"
  end

  test do
    system "drush", "version"
  end
end

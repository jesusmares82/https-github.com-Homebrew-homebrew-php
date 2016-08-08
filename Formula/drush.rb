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
    sha256 "0f46707595c05634597737791bc427a7f9a1b7450e5a462c13b32945a0ed91b9" => :el_capitan
    sha256 "231c8785154686ad61857409f7abf950f2705fe17228adbd70e19dd64b9fe67b" => :yosemite
    sha256 "eb4aa294efb119d8b4e48edfaa1a263400cd68fd7c8a86185eb75f2aacf66b46" => :mavericks
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

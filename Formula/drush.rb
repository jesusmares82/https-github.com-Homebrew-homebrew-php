require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  desc "A command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.0.3.tar.gz"
  sha256 "d089a5ea4d3aa56b2a8f62a201c1641143460236c1f1a57090236432bebcb64d"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3174d1b288e8f45e5e6c8be07191a3be36702d942a2876eef6b72bb260d29c3" => :el_capitan
    sha256 "34f4cf2aa08363e3785bcacc33fb69b860da8f7d229b7e103263d3a07c7b22c0" => :yosemite
    sha256 "5b96d66d0e8d03fe534b2d3616ccda12562271c35bcf9c6e8d9f5fb80aebb8e3" => :mavericks
  end

  head do
    url "https://github.com/drush-ops/drush.git"
  end

  depends_on PhpMetaRequirement
  depends_on "composer" => :build
  depends_on "php54" if Formula["php54"].linked_keg.exist?
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?

  def install
    system "composer", "install"

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

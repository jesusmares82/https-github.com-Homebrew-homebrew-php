require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.2.tar.gz"
  sha256 "439548afa60a21513268f2cc56d7443691a12967593ef99366b9f5689b7f7835"

  bottle do
    cellar :any_skip_relocation
    sha256 "ff66238e2f7e56fc29ad84432f39280158f83833e6593257d59d77c9469f9315" => :el_capitan
    sha256 "0598c5d4563a32af290d8d8164a3fe674dec72b5f3436ee15e5fb6a36b500d5a" => :yosemite
    sha256 "841c3682c363678e963f9f4f13870d46a335556fea01d56e5b8cc5150f90b3fd" => :mavericks
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

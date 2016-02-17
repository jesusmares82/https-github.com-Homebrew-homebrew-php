require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.0.3.tar.gz"
  sha256 "d089a5ea4d3aa56b2a8f62a201c1641143460236c1f1a57090236432bebcb64d"

  bottle do
    cellar :any_skip_relocation
    sha256 "fa5aa7a2962a13ed1be70d3d343668129901abe83bc495c77a88ffc96062b985" => :el_capitan
    sha256 "729b139674ae7ba2614ac4f78003a8eecbf8af79271304254935bf1c7f6e5691" => :yosemite
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

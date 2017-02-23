require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.10.tar.gz"
  sha256 "e81778d9ac742c04ba6fccf6de30e69ee4f92d1d03b03099d0a9d9b48b7bb6d9"
  head "https://github.com/drush-ops/drush.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e71ff5e482da51ec77350e6f5fd9b76dee0b62db68f8376f8a220a5558f0786" => :sierra
    sha256 "c40cfd0e2cc01451b7490b647aa73c195c49982307a81bff249856951c4d5c85" => :el_capitan
    sha256 "06618d4946b4e0add44b02d64dba2f82e7fe4d62ef8d2b2f43ceac9db77ea184" => :yosemite
  end

  depends_on PhpMetaRequirement
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?

  def install
    composer_install

    prefix.install_metafiles
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
    system "#{bin}/drush", "version"
  end
end

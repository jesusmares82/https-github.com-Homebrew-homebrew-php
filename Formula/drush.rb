require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.12.tar.gz"
  sha256 "55b9f78f3bf29907e93a898619618795d788db9ce5995eee4c3e33787d3a1404"
  head "https://github.com/drush-ops/drush.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "04606dd17301b6298fd03b6603ef434ae9d662e87b8bb797317a8503bce509fe" => :sierra
    sha256 "ed4945a8beccb75f5daa77b43ca709d1dcedbf7c39106b71f67c683fa752a3f0" => :el_capitan
    sha256 "24ac2ae967469376dc50f33a9e7ec3e2f6cff7ad035f19a2b523eff7f7fec899" => :yosemite
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

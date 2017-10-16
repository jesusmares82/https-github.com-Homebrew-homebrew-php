require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  include Language::PHP::Composer

  desc "Command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.1.14.tar.gz"
  sha256 "15a9b2e6c61087fe5b32ceee06c385f589300afc3e5d569d3eb01414317026d9"
  head "https://github.com/drush-ops/drush.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "98e59936071a91cf180840b8367baa16f2ab163a6ccace708fd346f796891f69" => :high_sierra
    sha256 "bd165e1646400a0f86a596cfd462cb0d9c0d7611f332632dce965f5aedfc1a80" => :sierra
    sha256 "fff9af5f340e1a983c6cb13034e624692baead7d57ed3605220c1eccfdd1d1b5" => :el_capitan
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

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
    sha256 "b1d4a50d4ca3595817e5e05f5ee40ba8f8fcfa369e26a9dde3f3e51c7acf16e5" => :sierra
    sha256 "5d7d8c05bda0b9d786b1cf07f8173c06d5ea27d821e2dcb4779a52781d3735d6" => :el_capitan
    sha256 "e349c4b81035a0877f1ed1e56492b2e3da92f8574702918406216d5c1ee5f95f" => :yosemite
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

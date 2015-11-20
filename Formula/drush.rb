require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Drush < Formula
  desc "A command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/8.0.0.tar.gz"
  sha256 "843cf1bff04cf86aff50ebd4ed2cf4b6713270d4e4aa2f60d575de85949121b0"

  bottle do
    cellar :any_skip_relocation
    sha256 "f9a536347662f032cdd974eb3cdde34f827fe4cfd58f659c20c09cdf139e0640" => :el_capitan
    sha256 "a1e2a683cf437d97227d612c00f06fb550cd921120a016a951208053254d0234" => :yosemite
    sha256 "2487e03d2c3f064fbb1996c95400f50c0bcc5691b3fe660d78394a003145534c" => :mavericks
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

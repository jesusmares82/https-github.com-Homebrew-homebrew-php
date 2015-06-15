class Drush < Formula
  desc "Drush is a command-line shell and scripting interface for Drupal"
  homepage "https://github.com/drush-ops/drush"
  url "https://github.com/drush-ops/drush/archive/7.0.0.tar.gz"
  sha256 "05b7c95902614812978559280a6af86fc7ad3946c11217fe4a14f9df7500d1dc"

  head do
    url "https://github.com/drush-ops/drush.git"
    depends_on "Homebrew/php/composer" => :build
  end

  def install
    system "composer", "install" if build.head?

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

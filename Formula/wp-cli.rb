require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v1.2.0.tar.gz"
  sha256 "0320f865a10ca412603abf7b502dfa7056a41f72f6319f3962663f1cf2d65392"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "509441f68257b69cbf0827b9ab7dd36545abbe52a22f3a47d7b2e8c8c5ab991a" => :sierra
    sha256 "b3dd9190c900c69e73d946ead59cac4958f6ab41559e5a2e412caa43294ee6d4" => :el_capitan
    sha256 "6dc4a892ba3a6bda87395836fb979f42e8ee3bceb19d4612ea75a0717a01d34d" => :yosemite
  end

  option "without-bash-completion", "Don't install bash completion"
  option "without-package-index", "Don't add package index repository (https://wp-cli.org/package-index)"

  def install
    composer_install

    rm "bin/wp.bat"
    prefix.install Dir["*"]

    if build.with? "bash-completion"
      (prefix + "etc/bash_completion.d").install "#{prefix}/utils/wp-completion.bash"
    end

    if build.with? "package-index"
      composer "config", "--file=#{prefix}/composer.json", "repositories.wp-cli", "composer", "https://wp-cli.org/package-index/"
    end
  end

  test do
    system "#{bin}/wp", "--info"
  end
end

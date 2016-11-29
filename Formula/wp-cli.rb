require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v1.0.0.tar.gz"
  sha256 "7fd238e93ff24ee417a40aa5e147545e8859f386a1c106e251ce34ca8dd84b15"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3c0f1fb5526d8da2e36211cbfe64c02c88a4c0eccb9274fc9b1c0cf742059fbc" => :sierra
    sha256 "7be663f849ed8e5429c7315a8bd0b3bb5a39af129d065698929585b135b5f1c8" => :el_capitan
    sha256 "9490de16f561f6ca135414ba125461888efe96b789562826b52ba68e0f4465f1" => :yosemite
  end

  option "without-bash-completion", "Don't install bash completion"
  option "without-package-index", "Don't add package index repository (http://wp-cli.org/package-index)"

  def install
    composer_install

    rm "bin/wp.bat"
    prefix.install Dir["*"]

    if build.with? "bash-completion"
      (prefix + "etc/bash_completion.d").install "#{prefix}/utils/wp-completion.bash"
    end

    if build.with? "package-index"
      composer "config", "--file=#{prefix}/composer.json", "repositories.wp-cli", "composer", "http://wp-cli.org/package-index/"
    end
  end

  test do
    system "#{bin}/wp", "--info"
  end
end

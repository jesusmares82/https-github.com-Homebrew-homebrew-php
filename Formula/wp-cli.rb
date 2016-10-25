require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.25.0.tar.gz"
  sha256 "98526f880619bf95959ae9812204af7de6949e295dc1dcb4f9007d0355c4f7c7"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8efef0002af9f34ac261868634ce51230dcf06a930b3bb671b82c954b4682d2a" => :sierra
    sha256 "a46a57c90fb71da8a212e65523ae6d6a7bb181a9a4d9206bc6aafc5bf023f907" => :el_capitan
    sha256 "04c0b701b3c326d53a8376123fb76f9c1ca6c3bfca46790dada86d56dff8084d" => :yosemite
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

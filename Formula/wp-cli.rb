require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.23.0.tar.gz"
  sha256 "ef3a77c6e5ef6f44cb26920fabe885ecb640d00a34a6bd897c9cd4f02b3e2635"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4bf18b2031e00e024ceca065bd8dfdb4c1fe54ccc0286cc79428a6d20a1094a1" => :el_capitan
    sha256 "7bdff576d3587034a1b2495388662366db1e6cd6d37c798e62b7b137ffd4ec6d" => :yosemite
    sha256 "4dbcd7780cc697ddc6707b50780b052b0f8749cc443566737b829f3816ab9183" => :mavericks
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

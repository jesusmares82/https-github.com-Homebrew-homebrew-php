class WpCli < Formula
  desc "A set of command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.21.1.tar.gz"
  sha256 "d8f27944e96fd67126c3d2611f36b57e1b5c1b6450822b4ae81182abf2bf4666"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c972eec7f4037041f093eafcfff0b687ed548baeca1f92c1c904237500bc1d0" => :el_capitan
    sha256 "b531f3d53109d20eb2f1aeda0d462463044834ceb40502d5c819e2e96f204d7b" => :yosemite
    sha256 "85243eefdeac9fc98ad3885ad4ca32e6a368f4c90f8184f8c5a0a9b94df5cc61" => :mavericks
  end

  option "without-bash-completion", "Don't install bash completion"
  option "without-package-index", "Don't add package index repository (http://wp-cli.org/package-index)"

  depends_on "composer" => :build

  def install
    system "composer", "install"

    rm "bin/wp.bat"
    prefix.install Dir["*"]

    if build.with? "bash-completion"
      (prefix + "etc/bash_completion.d").install "#{prefix}/utils/wp-completion.bash"
    end

    if build.with? "package-index"
      system "composer", "config", "--file=#{prefix}/composer.json", "repositories.wp-cli", "composer", "http://wp-cli.org/package-index/"
    end
  end

  test do
    system "#{bin}/wp", "--info"
  end
end

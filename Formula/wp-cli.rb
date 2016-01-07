class WpCli < Formula
  desc "A set of command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.22.0.tar.gz"
  sha256 "a51c8cea5e4bd8a210ed397b0639595515a6cc14e8a06c8e2138445d81bcbc86"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4bf18b2031e00e024ceca065bd8dfdb4c1fe54ccc0286cc79428a6d20a1094a1" => :el_capitan
    sha256 "7bdff576d3587034a1b2495388662366db1e6cd6d37c798e62b7b137ffd4ec6d" => :yosemite
    sha256 "4dbcd7780cc697ddc6707b50780b052b0f8749cc443566737b829f3816ab9183" => :mavericks
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

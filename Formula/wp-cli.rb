class WpCli < Formula
  desc "A set of command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.21.0.tar.gz"
  sha256 "de451fba0112d5cb9b895d2d6b87adb115aa6fc147c15a9594479f042f2745c4"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "64b686ce1dd71d68fdbb5c650ac82a4dc6da8749fa0802783c339cc676cc18a9" => :el_capitan
    sha256 "72c5b3a41ad90fbca69e8be9b7f56cf9af32109eba75ad5830b4ca6754f8e8ff" => :yosemite
    sha256 "f99eb3110ce787631b6e1f2888f4c8ecb97346058d81d27c8597a13a83373a65" => :mavericks
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

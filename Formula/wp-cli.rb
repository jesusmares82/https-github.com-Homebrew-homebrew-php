require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v1.3.0.tar.gz"
  sha256 "8a85cfe1f75546ecbc05d3201caaff2ce26b57b8251f0757291072fbccf6c37d"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "84cc1ba0087ebf1799716fcb612ad95b5d3ee9d1ed6b785218ad45d05f6b2f5b" => :sierra
    sha256 "7d9d54521d32f92ad06bab84ded0182f3125a985da0ed04c20dd7f905f467b24" => :el_capitan
    sha256 "fc2840f48f65de9207fe4a40f29e2e67e028adf77e10e16248346f5445ae15c3" => :yosemite
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

require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v1.2.1.tar.gz"
  sha256 "7919d28dc3570696d2971ded5a14701da7cc10ffcc87935b781c28e1601bdffb"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f9d41f7b1bdb6d688fbe7ec9783ea8c084cfdb8be24a5690c6d71157c5e7099a" => :sierra
    sha256 "56205bf15415228b4a7325e5fa4766eb3d6b1c16decc2a2e201543836ce1e310" => :el_capitan
    sha256 "3b368aa04b2d8701adbaf9235ea6414e04ac16967c094f4e5f5d2333ee1a9c86" => :yosemite
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

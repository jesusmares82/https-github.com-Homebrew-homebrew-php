require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.24.0.tar.gz"
  sha256 "43b1cefdfc7eb18433f369a1022123ff4d2d53eedf6670e9a29188735bbf7660"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "803f1c2db06541531ab05546932621f5f6136a6c3a8671d608d6930acd8c9fa7" => :el_capitan
    sha256 "f040e0b672cbccaa7807450ce0d6c3e1cef2c4b583e92e0b36aa56f3b42d4cf6" => :yosemite
    sha256 "a3f00aeb3dfa9d660965ec3b48d018a9168fa7310b981780cb12787800e28773" => :mavericks
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

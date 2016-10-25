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
    sha256 "b6fa8b94406b72a79c980c8ff9606528d7ecf12fcb721ce78b5f2599402a7417" => :sierra
    sha256 "518178abc782ca4bf4509334fcc4f2305aef76027263b41b5a5c60fa238c6399" => :el_capitan
    sha256 "48728b492cbc54b363d5bb6287a967a43565810eea7c0cae1906206fa270d3ff" => :yosemite
    sha256 "a537a3d0ffef87552e1f9f980c852370479a65035a9e596000ea84b8dfda8eb3" => :mavericks
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

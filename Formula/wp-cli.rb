require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.24.1.tar.gz"
  sha256 "df6dc42349fbe658c8c5a4fb2664b0eefe74a1fa4fba163f7db047fe4200c512"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0c781d66b2247bdd3abc92211e63bacf57f31787c04b8f3719d3a9b4093a5e92" => :el_capitan
    sha256 "96c0f7ac8164e9668a96914b97934a5bb501670d5b7d44fd5444c0dc6896ada0" => :yosemite
    sha256 "9b684a473120d822e10a58fd0a65af01369b5a4ef0a23453b55488511fc672e7" => :mavericks
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

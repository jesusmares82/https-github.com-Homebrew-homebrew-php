require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "http://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v0.23.1.tar.gz"
  sha256 "a70d80b443ca95df7458329fc78e93d7c9c97cb6ac57eaebbce1e20048470a2a"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2b77bf5e682a2f25c48517b4f05b9eaa315bc29da236082bbfe43571b26b5813" => :el_capitan
    sha256 "19b4630405e6d9012b899acf00699fc625658e9ded1edd22289984d9d58a34fa" => :yosemite
    sha256 "8a1f6bdbf87b640954e1abdd905e79ec631f08cc3ccfdf57688df0f21b96d687" => :mavericks
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

class WpCli < Formula
  homepage "https://github.com/wp-cli/wp-cli"
  head "https://github.com/wp-cli/wp-cli.git"
  url "https://github.com/wp-cli/wp-cli/archive/v0.19.1.tar.gz"
  sha256 "924bdc47011067be7979c3817ec40c44e8bd68faa44ddc838881d4a2cffd778a"

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
      system "composer config --file=#{prefix}/composer.json repositories.wp-cli composer http://wp-cli.org/package-index/"
    end
  end

  test do
    system "#{bin}/wp", "--info"
  end
end

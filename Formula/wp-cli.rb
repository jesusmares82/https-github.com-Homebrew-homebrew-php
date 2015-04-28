class WpCli < Formula
  homepage "https://github.com/wp-cli/wp-cli"
  head "https://github.com/wp-cli/wp-cli.git"
  url "https://github.com/wp-cli/wp-cli/archive/v0.19.0.tar.gz"
  sha256 "74a0f04a653f183f542d5711333a860d8639fd925c966bb2f2bd235f3c768fce"

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

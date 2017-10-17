require File.expand_path("../../language/php", __FILE__)

class WpCli < Formula
  include Language::PHP::Composer

  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org/"
  url "https://github.com/wp-cli/wp-cli/archive/v1.4.0.tar.gz"
  sha256 "fa7a349db23969709b50f389b18efbde48fc7903939acb99452508f4b5221bbd"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "da7f89e16bd7edee1bcda991d9a7bb3994944b4d44b2a482a0ccfc7699ee8701" => :high_sierra
    sha256 "5e656b889cf9e1515c503267934230042fc8ac97dcdd4840c26f10f286c95f14" => :sierra
    sha256 "6e674330f25ac5b8951d1ce36359ebdd9d080448538be46b73bcec0b37d480af" => :el_capitan
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

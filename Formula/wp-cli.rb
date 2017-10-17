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
    sha256 "1a3e4e3cf2c78eb78a0be0d2578495d2f8935fba5813d0b55aab1cf581308c9e" => :sierra
    sha256 "dc298bf8a9c8167d3b8b092c0859e1e0af5569b55f25e8997673417136769ed4" => :el_capitan
    sha256 "7467ca543842f656f4ef2f2142695b3d3e05a2ddbd1fe788121850c5acdb773d" => :yosemite
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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class WpCli < AbstractPhpPhar
  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org"
  url "https://github.com/wp-cli/wp-cli/releases/download/v1.4.1/wp-cli-1.4.1.phar"
  sha256 "325924cf161856f9478f2a154572698ecb5d1054e620843b9c43a7baf4e5ce3b"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "da7f89e16bd7edee1bcda991d9a7bb3994944b4d44b2a482a0ccfc7699ee8701" => :high_sierra
    sha256 "5e656b889cf9e1515c503267934230042fc8ac97dcdd4840c26f10f286c95f14" => :sierra
    sha256 "6e674330f25ac5b8951d1ce36359ebdd9d080448538be46b73bcec0b37d480af" => :el_capitan
  end

  def phar_file
    "wp-cli-#{version}.phar"
  end

  def phar_bin
    "wp"
  end

  test do
    system "#{bin}/wp", "--info"
  end
end

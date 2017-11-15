require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class WpCli < AbstractPhpPhar
  desc "Command-line tools for managing WordPress installations."
  homepage "https://wp-cli.org"
  url "https://github.com/wp-cli/wp-cli/releases/download/v1.4.1/wp-cli-1.4.1.phar"
  sha256 "325924cf161856f9478f2a154572698ecb5d1054e620843b9c43a7baf4e5ce3b"
  head "https://github.com/wp-cli/wp-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "70954b082e4b806ba0ca0f78e19bcad2d4ee641d28f13ab6a0e5df82db135b4a" => :high_sierra
    sha256 "70954b082e4b806ba0ca0f78e19bcad2d4ee641d28f13ab6a0e5df82db135b4a" => :sierra
    sha256 "70954b082e4b806ba0ca0f78e19bcad2d4ee641d28f13ab6a0e5df82db135b4a" => :el_capitan
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

require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class DrushLauncher < AbstractPhpPhar
  desc "A small wrapper around Drush for your global $PATH."
  homepage "https://github.com/drush-ops/drush-launcher"
  url "https://github.com/drush-ops/drush-launcher/releases/download/0.4.3/drush.phar"
  sha256 "7da7bf2552da681a1a87788d4c4a34abdc0ace47bc9ddc395d8fc88480e13dde"

  bottle do
    cellar :any_skip_relocation
    sha256 "d08e7e85b3b70a369efba60d6cb8d101a78a63f2bbe2082c97ecadcb9c62ead3" => :high_sierra
    sha256 "1e04852795c2dcd5866aafa63dc32018175f674dd6049fdb03975884fcb8137e" => :sierra
    sha256 "1e04852795c2dcd5866aafa63dc32018175f674dd6049fdb03975884fcb8137e" => :el_capitan
  end

  def install
    bin.install "drush.phar" => "drush"
  end

  test do
    system "#{bin}/drush", "--drush-launcher-version"
  end

  conflicts_with "drush", :because => "because both provide a 'drush' executable"
end

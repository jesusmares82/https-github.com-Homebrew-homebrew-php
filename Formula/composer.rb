require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.0/composer.phar"
  sha256 "1acc000cf23bd9d19e1590c2edeb44fb915f88d85f1798925ec989c601db0bd6"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "1e430acc2e93be0726cf3963e31e40e4e5b1b0946af12a759029160d7c2dbb38" => :el_capitan
    sha256 "4c3c9767f10a1cf5fcc0c5948be2c02233f61d058286c637d2f31578c7a1d766" => :yosemite
    sha256 "2cd105467d909d9ae17361c71647e1b2d5d336aac00179cc493fc7182b8ac740" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end

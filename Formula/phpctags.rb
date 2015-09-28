require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpctags < AbstractPhpPhar
  init
  desc "Ctags compatible index generator written in pure PHP"
  homepage "https://github.com/vim-php/phpctags"
  url "https://github.com/vim-php/phpctags/archive/v0.5.1.tar.gz"
  sha256 "65e875c326876016fc1c63341348fab24f6a5b01ce1010f1357e3d87084f832b"

  bottle do
    cellar :any_skip_relocation
    sha256 "224929f6dcd4636ceee521b844aae6dc6546bead5ecd0b38f6ce1bd903803f65" => :el_capitan
    sha256 "ec9d9fa74651345dc91e6ade97ee8de7efdd979589a754579028281385663d29" => :yosemite
    sha256 "4097209b490a39815a2374729dbe36f39ba47a0435eb3fbe26ae8ac4c62f5abf" => :mavericks
  end

  def install
    system "make"
    bin.install "phpctags"
  end

  test do
    system "phpctags", "--version"
  end
end

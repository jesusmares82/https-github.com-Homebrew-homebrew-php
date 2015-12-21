require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Climb < AbstractPhpPhar
  init
  desc "Composer version manager tool"
  homepage "https://github.com/vinkla/climb"
  url "https://github.com/vinkla/climb/releases/download/0.8.0/climb.phar"
  sha256 "72c7dfa15d86b8c09bd0628bc11bed79ce00c9c03ce77fbbfed8f347cb6d96d9"

  bottle do
    cellar :any_skip_relocation
    sha256 "b63779bd7955e39cacbbf241505626cb715b20a2ae2714b442aabf37666863c3" => :el_capitan
    sha256 "5e917f407c10d86e7952522ee89bf77837fb0bf3b6602ccb9177223b30675cb3" => :yosemite
    sha256 "9299ac3cf99c2478d789673ac08262de95d280740ee402c7064f3551d6357dcd" => :mavericks
  end

  test do
    system "climb", "--version"
  end
end

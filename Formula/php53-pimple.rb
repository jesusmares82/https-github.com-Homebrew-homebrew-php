require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pimple < AbstractPhp53Extension
  init
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "59594789bd376d0d447d0f0ff682115fec2a816bfa937991f05dbc5b4f872ba3" => :el_capitan
    sha256 "61c9b6d7994d8257955d63562d4ce51e4ef133428f329a07837629c0e911202f" => :yosemite
    sha256 "61298fb221f2f240693481ea18aaba92b5a36294d56c475a0d4d81aa2aa34e07" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "ext/pimple" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install %w[modules/pimple.so]
    end
    write_config_file if build.with? "config-file"
  end
end

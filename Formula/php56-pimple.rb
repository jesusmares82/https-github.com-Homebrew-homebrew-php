require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pimple < AbstractPhp56Extension
  init
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6ac2750627efde376481ae8b0e8998f6a72000e3ac26076502bfc5304c679cd7" => :el_capitan
    sha256 "f82b6b79fef69ba6e28e3a3ec1d4dffe3d856ca05efaed791010ce92cfdbd30c" => :yosemite
    sha256 "4113fad0a3de6be9212cfdddab8bea728caac1aecf2f79f3997a1bb4f9aac5fd" => :mavericks
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

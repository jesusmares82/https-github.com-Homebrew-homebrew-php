require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pimple < AbstractPhp54Extension
  init
  desc "Pimple is a simple PHP Dependency Injection Container."
  homepage "http://pimple.sensiolabs.org/"
  url "https://github.com/silexphp/Pimple/archive/v3.0.0.tar.gz"
  sha256 "591e706f5cdce06bdd17d306db3fe9df521bee0ef4fcb0ee56524ff258ef66ba"
  head "https://github.com/silexphp/Pimple.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ae216da393758542d3ecd8090e006a5171265216b7770353becedc333af8efa4" => :el_capitan
    sha256 "671529d07451c6a9863540486ffc846d163a9e3dfa2cfdac742716d61818e412" => :yosemite
    sha256 "91b99830b74c4cd94df87b2f65b3271092bb46d165084ab5dc5724eda90839cc" => :mavericks
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

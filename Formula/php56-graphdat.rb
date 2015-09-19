require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Graphdat < AbstractPhp56Extension
  init
  homepage 'http://www.graphdat.com/'
  url 'https://pecl.php.net/get/graphdat-1.0.3.tgz'
  sha256 '6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799'
  head 'https://github.com/alphashack/graphdat-sdk-php.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "727c38dd6222fac50eb9453b3b9d98c52d8b742d942874e1f187cba3e53d805e" => :el_capitan
    sha256 "03d3287d90d658e11f8242d170dbcd681b9339fa1795235248fd7f4776df0d2e" => :yosemite
    sha256 "43bf2b268d0086bc513428beb94b8cc99946948bf1c5d8825f0f59df71b4a897" => :mavericks
  end

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file if build.with? "config-file"
  end
end

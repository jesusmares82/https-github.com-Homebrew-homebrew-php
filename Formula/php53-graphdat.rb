require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Graphdat < AbstractPhp53Extension
  init
  homepage 'http://www.graphdat.com/'
  url 'https://pecl.php.net/get/graphdat-1.0.3.tgz'
  sha256 '6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799'
  head 'https://github.com/alphashack/graphdat-sdk-php.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "b95b7e8544794edfa3ed766f683f04cc3316300f8b420efb014ff8c54f36b182" => :el_capitan
    sha256 "8f481c1743ae6646e31b822431b47ea9a34cf665f57a8d9a801db15078bf7d17" => :yosemite
    sha256 "5b578e4c68ec846075d2bb6b0287f62a51d5e079d20bba78b3f41fe08edd989b" => :mavericks
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

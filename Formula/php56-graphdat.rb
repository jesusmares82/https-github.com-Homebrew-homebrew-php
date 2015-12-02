require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Graphdat < AbstractPhp56Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ddca7ce11952ebf814387d36c991e7e981220f7da6cd72c72810ee1b4b04e8d0" => :el_capitan
    sha256 "2cdfc6c2f737089b82acbe85936b62316c538eeaf063fd02cdd909660b1275b0" => :yosemite
    sha256 "a21614d2557246c43e977e8a40b9cfc49f112f024dc3842025be055a1dc465a9" => :mavericks
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.0.0.tgz"
  sha256 "f44424e1bd9aaf11caee1ec1baf4bd46e71afd832a0b3411d2f3dfaf1bef5377"

  bottle do
    cellar :any
    sha256 "befbefc9422b89715fb9e684cc2c6201003106fa96534514123fc896fac29264" => :el_capitan
    sha256 "1d81c7c93b77569d3b7efffdc48353b4e79a1f5de82e4b7b8c7e442c52bffc00" => :yosemite
    sha256 "ae03a50b337ad7b9486426bbc22bc24a4b3b07272fb6d5a2a2bf27ca2b98c51c" => :mavericks
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.3.6.tgz"
  sha256 "65b8234701e9c563ab4cb0eb2ab0b0ef696c3d40c3498fc4ba6069459fc0e974"

  bottle do
    cellar :any
    sha256 "d5589154a44002efd39765954f7771ffe54cf446cab79ff57a3d0cfd450c25fd" => :sierra
    sha256 "6dde602b2c4df0065b2b29abb4a240af29e92652872d3a67d5b9671badbe6268" => :el_capitan
    sha256 "3f7e592fdf9567b2248b154116431bb17c1a40d3046ce4fd726ff16ce775c86c" => :yosemite
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

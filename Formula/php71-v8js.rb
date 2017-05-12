require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.0.tgz"
  sha256 "c9401ed72a14e332661f64516d7ab13fe39c726e9c283cb3c81ccd786309494a"

  bottle do
    cellar :any
    sha256 "408e93666e97fa4415395259860d5a8fffaf9068469c16492010a965022c4668" => :sierra
    sha256 "0ff19669648fd3ef451bca1e812b827fc87c7d35cd60b2574beca186dde1202d" => :el_capitan
    sha256 "4eb4de747eea642aba4b7696d37101efefb16081134bf435f57100e007e45553" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end

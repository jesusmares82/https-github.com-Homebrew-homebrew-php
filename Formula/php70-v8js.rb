require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.0.tgz"
  sha256 "c9401ed72a14e332661f64516d7ab13fe39c726e9c283cb3c81ccd786309494a"

  bottle do
    cellar :any
    sha256 "120e273325b721c4f54ba283a834301e12707ff564197bed6ed29931d2d9ea08" => :sierra
    sha256 "f56ef1676db24b7fc34948cb1bc44d3d7199e1cd89bf4996382e1be1d45f5030" => :el_capitan
    sha256 "0eaab1b0e5866a8cbaedfd5a601332a207c9649f338e7bd05a2c480f61c7e65a" => :yosemite
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

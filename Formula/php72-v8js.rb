require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72V8js < AbstractPhp72Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.0.tgz"
  sha256 "2f1b990f91b8ee278a7f29e0f9dadfa694516d489493f1f05bcfb208a16fc33c"
  head "https://github.com/phpv8/v8js.git"

  bottle do
    cellar :any
    sha256 "de8701069e35e9b23d8bdfcc7d1626426de777f3d70624a33a1d2fe26ad582bc" => :sierra
    sha256 "4a29df0dcb00c00475da0038b797930440abbd351382a06c019965b0b27832ee" => :el_capitan
    sha256 "77b13ce4d6468d36b9c585a30912ffda33db094943608067cbe901dd556e0147" => :yosemite
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

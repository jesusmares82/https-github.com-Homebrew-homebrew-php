require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.0RC4.tgz"
  sha256 "55f8c906d8e7413c872e91db599082f18c3e49c736adf977333cd313fae635e8"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a60f80591567df2f4afca8985fc7d0bc09d3f35c7ae905175e7e794283a91bcf" => :el_capitan
    sha256 "0d1b61c00df2035a46c1534b7052a34d602ec984cac1aeed4539811949519dbf" => :yosemite
    sha256 "45dc5f93f72bfc29ff6dd965642097e506d072efd85e027ca5a71063e4a51acd" => :mavericks
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end

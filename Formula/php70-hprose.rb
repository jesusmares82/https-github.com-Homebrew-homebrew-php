require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Hprose < AbstractPhp70Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.5.tgz"
  sha256 "a453053719dad6352d54543d708d8d09b62de28df7b29fd47b4b5a9fcf8025a7"
  head "https://github.com/hprose/hprose-pecl.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "a7616a382e8ee52cc582c04166b2a601ea16ec897cfd22f6b3ae608b0c43255e" => :el_capitan
    sha256 "81a3a8eab2bac375470c951709cccb4abd61066fb9511ac81331b06da8ef463e" => :yosemite
    sha256 "20db3f02920288d9c3d1869ec6d7de8586fc32804d3ae765e7760700c2549a4d" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end

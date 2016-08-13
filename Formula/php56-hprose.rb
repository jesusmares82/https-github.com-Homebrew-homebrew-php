require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.5.tgz"
  sha256 "a453053719dad6352d54543d708d8d09b62de28df7b29fd47b4b5a9fcf8025a7"
  head "https://github.com/hprose/hprose-pecl.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "1e40537205c9ca545bc9d7c06166bfa6c49b12ed01070e21fcfd2c5370447c3e" => :el_capitan
    sha256 "d9d6b044913cfb5f451605832de12c8a608c4ad42d32c50f2cf7ae5d4f7ef838" => :yosemite
    sha256 "9183f25c52315d58d52932406d2714aa57a162e1e968be751d268ee460a6f207" => :mavericks
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

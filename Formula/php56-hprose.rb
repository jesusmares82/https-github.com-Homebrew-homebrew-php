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
    sha256 "18b0070420a14dedcef1898b7667685b14f4e618e45f5dcae15cb8e5f62abda9" => :el_capitan
    sha256 "a124951003ce52040e7d1c112413796f0e3e9cd482a9826f63e0aa7e85f3cbea" => :yosemite
    sha256 "569df5f46c1c068f4c0a950732eb7a0aca3500d724e5c2a5eddffdf351cbd973" => :mavericks
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

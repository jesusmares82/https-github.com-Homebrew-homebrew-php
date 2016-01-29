require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Hprose < AbstractPhp54Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.4.tgz"
  sha256 "e3d96cc51cf442629e7298af153c55e4bd85d832de43f22eb5f0fabe49abacca"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "14b6fd0d0ce33b6b2ebfebda7342551d04e5cf3df8ac45900c77a70a8d0536fa" => :el_capitan
    sha256 "6d3f4b6c36c735827f61dfba36096d92fe3d13da2d73d404905098f4d4e204dc" => :yosemite
    sha256 "cf6b1027df0cb719e8a6934cc104ebba225b632a993e97c4d01ead1138d61c03" => :mavericks
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

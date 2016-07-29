require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Hprose < AbstractPhp71Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.5.tgz"
  sha256 "a453053719dad6352d54543d708d8d09b62de28df7b29fd47b4b5a9fcf8025a7"
  revision 2
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a3a158ba2b1652d2c1f3656b9a1e53f4aa8b2b4996adaa8c656a9cbfb0fa923d" => :el_capitan
    sha256 "0083fc1df742ff7106e741c06cff6ec9fce8886e796447146d26e2c0f11b9039" => :yosemite
    sha256 "bd32f4148024df3d09907855047032502fe2e76fb089ec5f67ade0bd327bebf6" => :mavericks
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

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Hprose < AbstractPhp53Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.4.tgz"
  sha256 "e3d96cc51cf442629e7298af153c55e4bd85d832de43f22eb5f0fabe49abacca"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dae631c1dede2495783bf7826bb484c8c1efec777455f66e51444e42e4cb08f8" => :el_capitan
    sha256 "cea41fc6af5a53b171ab7a74dc40ab2d1b7e2ab52ae376f6909d32fbccfbbdc2" => :yosemite
    sha256 "258a9c95225abae29e7cc2694f0baf113d85591936d9901aa8d92a914a37938a" => :mavericks
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

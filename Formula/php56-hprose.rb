require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.4.tgz"
  sha256 "e3d96cc51cf442629e7298af153c55e4bd85d832de43f22eb5f0fabe49abacca"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4687e62e7b04266ff22740de8ba78406101b483f085b176ac2e865b6434da829" => :el_capitan
    sha256 "6d49c9b0225bf611dfe2e0ed958d02d156c551e36beb9545559f96d122fdde18" => :yosemite
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

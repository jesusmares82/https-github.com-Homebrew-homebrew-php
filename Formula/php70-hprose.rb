require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Hprose < AbstractPhp70Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.4.tgz"
  sha256 "e3d96cc51cf442629e7298af153c55e4bd85d832de43f22eb5f0fabe49abacca"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4dc36f5ca3d6210f41f97029b960b12a4d998ccc6da97563955cf40e94848c07" => :el_capitan
    sha256 "f271ee58bd5a90fa614d8da93762e664e28a7ef998d5961f07a5a2edd08294d7" => :yosemite
    sha256 "334c63be492ab06201fa4160420de4de2694ed7c4bb5940810dd3505eb25f8bd" => :mavericks
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

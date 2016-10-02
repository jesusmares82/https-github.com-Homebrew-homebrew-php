require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ssh2 < AbstractPhp71Extension
  init
  desc "Provides bindings to the functions of libssh2"
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-1.0.tgz"
  sha256 "6a93891878b23904a773eb814fec7aea4ea00b4a412ee779c8535ed9c5e46ced"
  head "https://github.com/php/pecl-networking-ssh2.git"

  bottle do
    sha256 "7bdb69915afa6f87c2b6f3d754936e20c3f1f6c48185fec02dd752841409ec5b" => :sierra
    sha256 "08407a7adb4e8bb7b13bd4992ddc18dbb0e8777128d13be09fcd2bf13ef19f01" => :el_capitan
    sha256 "9375514009a258db3f5de3e4001ff6806e2de8acb016363fc685aecc513ac45a" => :yosemite
  end

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end

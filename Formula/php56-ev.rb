require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ev < AbstractPhp56Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7cb4b47ec84d42d2fff31711cd4811f0f757ac5fb60d449c30915981855399b1" => :el_capitan
    sha256 "3c3baf440535f5d510465aa44b38205103f3213a4e616db78f5f5c2a70b62d76" => :yosemite
    sha256 "05286cf12889c5320fc7ce4e25a257872079f89518a189951da0fcafb115a5c0" => :mavericks
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end

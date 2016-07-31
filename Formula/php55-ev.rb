require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ev < AbstractPhp55Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3ca928c2fb301466a8d556883b0d3e7b180a437cd4da83263bc175514ea93c2e" => :el_capitan
    sha256 "ca94e65f28b7aeb4778226ec6873b5566fe95784611c744b71d6e7352ac92fdb" => :yosemite
    sha256 "7ff0b1e3e649e16173f25770bc77e31873261339a0043037b9f4efc545e8c41a" => :mavericks
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

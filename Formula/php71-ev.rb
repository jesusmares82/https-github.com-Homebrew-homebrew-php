require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ev < AbstractPhp71Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "13bf162680736e0a350b704b2f72103c045d9b98331b1b42a726b641fd0b92da" => :el_capitan
    sha256 "d4eebd7515d09b3cf3583f4d1e584c841526fb8e30f5a555aa8d6bccb05a3d85" => :yosemite
    sha256 "b6cb605da3ea96f36354b96ad6439954da97e152762c021152075ae5d9d6a3b1" => :mavericks
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

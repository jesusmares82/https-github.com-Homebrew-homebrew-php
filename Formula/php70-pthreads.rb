require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pthreads < AbstractPhp70Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-3.1.4.tgz"
  sha256 "2d13304bad6829a5e43d91bad8d234b03cd5f9acbbc1134c5a4c04e827b5076c"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a0ff43376fcd94d2b45a978ef9d9d32c1277763393d7f9afc8179d424e5c867c" => :el_capitan
    sha256 "f2d037cc45ff604335b401da01c6a15d5816d8e45863e8b5e5945ea50a30b29a" => :yosemite
    sha256 "ccb2ebaa4244dc877511030547398f3682be964e3081be1142134b9ec418a94a" => :mavericks
  end

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end

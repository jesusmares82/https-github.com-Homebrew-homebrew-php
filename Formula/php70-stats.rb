require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Stats < AbstractPhp70Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.1.tgz"
  sha256 "994da82975364773248091bb3f83cc5f101db70e88c79af8a60bea8ad054dd06"
  head "https://git.php.net/repository/pecl/math/stats.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d0399e8c5542bb7097c523a8f4e3953a29a9653e9073e96c8488c606a8aeb8dd" => :el_capitan
    sha256 "1f0eca75dce69254160857462e128313ef1331605be9f3f2469df033817d3d83" => :yosemite
    sha256 "2b895946a0310cf3818696c73bdcbea703b9dc423b719bd005f439ba22f984e2" => :mavericks
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end

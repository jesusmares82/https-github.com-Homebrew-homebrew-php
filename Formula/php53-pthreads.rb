require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pthreads < AbstractPhp53Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-2.0.10.tgz"
  sha256 "8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "25bf089fca730e123ad15e31783977ba59f169d5cb920316ec439b31ed843640" => :el_capitan
    sha256 "e1b0a3f42609edde2aef6060a6448f7bea8219a76716cbb1bbf872e96d2e472f" => :yosemite
    sha256 "5e15282b3a7efeeb713156752a00bdd9ce515136c58b98edd0aedf53d4be9a55" => :mavericks
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

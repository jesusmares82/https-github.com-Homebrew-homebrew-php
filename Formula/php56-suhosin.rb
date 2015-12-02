require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Suhosin < AbstractPhp56Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "http://suhosin.org/stories/index.html"
  url "https://github.com/stefanesser/suhosin/archive/0.9.37.1.tar.gz"
  sha256 "322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    sha256 "61f11b90b3325bc3ba945e632191aedd539f87c5233c3ab49e6569f5561d26a8" => :yosemite
    sha256 "15d7cdd36e5a50d57951f873a4bc77ee14feeed6f1ffdf3f0cdb972a7335b1f3" => :mavericks
    sha256 "34c0f66f20f4d5e4f12fa1a05adfad1dc253bc9bbc328011afb72ef3f21eb7e4" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
